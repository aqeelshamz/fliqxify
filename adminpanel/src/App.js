import axios from "axios";
import { useEffect, useState } from "react";
import serverUrl from "./utils";
import "./App.css";

function App() {
  useEffect(() => {
    getPopularMovies();
  }, []);

  const [progress, setProgress] = useState(0);
  const [uploading, setUploading] = useState(false);

  const [movies, setMovies] = useState([]);
  const [movieId, setMovieId] = useState("");

  function getPopularMovies() {
    const config = {
      url: "https://api.themoviedb.org/3/movie/popular?api_key=3794a566770835ffed011b687794a132&language=en-US&page=1",
      method: "get",
    };

    axios(config)
      .then((response) => {
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
    setUploading(true);
    const data = new FormData();
    data.append("file", e.target.files[0]);
    data.append("movieId", movieId);

    const axiosInstance = axios.create({
      baseURL: `${serverUrl}`,
    });

    axiosInstance.post("/movies/upload", data, {
      headers: {
        "Content-Type": "multipart/form-data",
      },
      onUploadProgress: (data) => {
        const progress = Math.round((100 * data.loaded) / data.total);
        setProgress(progress);
        setDataLoaded(data.loaded);
        setDataTotal(data.total);
      },
    });
  };

  const [keyword, setkeyword] = useState("");
  const [movieName, setMovieName] = useState("");

  const [dataLoaded, setDataLoaded] = useState(0);
  const [dataTotal, setDataTotal] = useState(0);

  return (
    <div className="App">
      <h1>Fliqxify Admin Panel</h1>
      <h2>Upload Movie</h2>
      <br />
      <div className="column">
        <div className="column">
          <p>{movieName}</p>
          <br />
          {uploading ? (
            <div className="column">
              <div id="progress-bar">
                <div id="progress" style={{ width: (progress * 500) / 100 }} />
              </div>
              <div
                className="row"
                style={{
                  justifyContent: "space-between",
                  marginTop: "10px",
                  width: "500px",
                }}
              >
                <p>
                  {progress}%{progress === 100 ? " Uploaded" : ""}
                </p>
                <p>
                  {parseInt(dataLoaded / 1024 / 1000).toString().length > 3
                    ? (parseInt(dataLoaded / 1024 / 1000) / 1000).toFixed(2)
                    : parseInt(dataLoaded / 1024 / 1000)
                        .toFixed(2)
                        .toString()}{" "}
                  {parseInt(dataLoaded / 1024 / 1000).toString().length > 3
                    ? "GB"
                    : "MB"}{" "}
                  /{" "}
                  {parseInt(dataTotal / 1024 / 1000).toString().length > 3
                    ? (parseInt(dataTotal / 1024 / 1000) / 1000).toFixed(2)
                    : parseInt(dataTotal / 1024 / 1000).toFixed(2)}{" "}
                  {parseInt(dataTotal / 1024 / 1000).toString().length > 3
                    ? "GB"
                    : "MB"}
                </p>
              </div>
            </div>
          ) : (
            <>
              <input
                type="text"
                value={movieId}
                onChange={(e) => {
                  setMovieId(e.target.value);
                }}
                placeholder="Movie ID"
              />
              <br />
              {movieId === "" ? (
                ""
              ) : (
                <>
                  <p>Upload Movie File:</p>
                  <br />
                  <input type="file" onChange={uploadMovie} />
                </>
              )}
            </>
          )}
        </div>
        <div className="column">
          <br />
          <input
            type="text"
            value={keyword}
            onChange={(e) => {
              searchMovie(e.target.value);
              setkeyword(e.target.value);
            }}
            placeholder="Search Movie"
          />
          {keyword.length === 0 ? (
            ""
          ) : (
            <>
              {searchResults.map((item, index) => {
                return (
                  <div
                    id="search-result"
                    onClick={() => {
                      setMovieId(item.id);
                      setkeyword("");
                      setMovieName(item.title);
                      setUploading(false);
                    }}
                  >
                    <div className="row">
                      <img
                        src={`https://image.tmdb.org/t/p/w200/${item.poster_path}`}
                        alt="poster"
                      />
                      <div className="column">
                        <p id="title">{item.title}</p>
                        <p id="id">{item.id}</p>
                      </div>
                    </div>
                  </div>
                );
              })}
            </>
          )}
          <br />
          <br />
        </div>
      </div>
    </div>
  );
}

export default App;
