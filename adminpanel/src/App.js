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

  const uploadMovie = (e) => {

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
        console.log("Movie uploaded");
      })
      .catch((err) => console.log("Something went wrong"));
  };

  return (
    <div className="App">
      <h1>Fliqxify Admin Panel</h1>
      <h2>Upload Movie</h2>
      <input type="file" onChange={uploadMovie} />
      <p>Movie ID</p>
      <input
        type="text"
        value={movieId}
        onChange={(e) => {
          setMovieId(e.target.value);
        }}
      />
      {movies.map((item, index) => {
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
