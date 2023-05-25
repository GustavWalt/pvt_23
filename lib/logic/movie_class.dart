class Movie {
  final String title;
  final String year;
  final String released;
  final String genre;
  final String plot;
  final String imdbRating;
  final String imdbVotes;
  final String poster;

  const Movie(
      {required this.title,
      required this.year,
      required this.released,
      required this.genre,
      required this.plot,
      required this.imdbRating,
      required this.imdbVotes,
      required this.poster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    if (json['Title'] == null) {
      return Movie(
        title: "",
        year: "",
        released: "",
        genre: "",
        plot: "",
        imdbRating: "",
        imdbVotes: "",
        poster: "",
      );
    } else {
      return Movie(
          title: json['Title'],
          year: json['Year'],
          released: json['Released'],
          genre: json['Genre'],
          plot: json['Plot'],
          imdbRating: json['imdbRating'],
          imdbVotes: json['imdbVotes'],
          poster: json['Poster']);
    }
  }
}
