import axios from "axios";
import { useEffect, useState } from "react";
import serverUrl from "./utils";

function App() {
  useEffect(() => {
    getPopularMovies();
  }, []);

  const [movies, setMovies] = useState([]);
  const [movieId, setMovieId] = useState("");

  function getPopularMovies() {
    const config = {
      url: "https://api.themoviedb.org/3/movie/popular?api_key=3794a566770835ffed011b687794a132&language=en-US&page=1",
      method: "get",
    };

    axios(config)
      .then((response) => {
        console.log(response.data.results);
        setMovies(response.data.results);
      })
      .catch((err) => {});
  }

  const [searchResults, setSearchResults] = useState([]);

  function searchMovie(keyword) {
    const config = {
      url:
        "https://api.themoviedb.org/3/search/movie?api_key=3794a566770835ffed011b687794a132&language=en-US&page=1&include_adult=false&query=" +
        keyword,
      method: "get",
    };

    axios(config)
      .then((response) => {
        console.log(response.data.results);
        setSearchResults(response.data.results);
      })
      .catch((err) => {});
  }

  const uploadMovie = (e) => {
    if (movieId === "") {
      alert("Enter Movie ID");
      window.location.reload();
      return;
    }

    const data = new FormData();
    data.append("file", e.target.files[0]);
    data.append("movieId", movieId);

    const config = {
      method: "post",
      url: `${serverUrl}/movies/upload`,
      data: data,
    };

    axios(config)
      .then((response) => {
        alert("Movie uploaded");
        window.location.reload();
      })
      .catch((err) => {
        alert("Something went wrong");
        window.location.reload();
      });
  };

  return (
    <div className="App">
      <h1>Fliqxify Admin Panel</h1>
      <h2>Upload Movie</h2>
      <br />
      <p>Enter Movie ID:</p>
      <input
        type="text"
        value={movieId}
        onChange={(e) => {
          setMovieId(e.target.value);
        }}
      />
      <br />
      <br />
      <p>Select Movie File to Start Upload:</p>
      <input type="file" onChange={uploadMovie} />
      <br />
      <br />
      <br />
      <p>Search movies for Movie ID:</p>
      <input type="text" onChange={(e) => searchMovie(e.target.value)} />
      {searchResults.map((item, index) => {
        return (
          <p>
            {item.id} - {item.title}
          </p>
        );
      })}
    </div>
  );
}

export default App;
