class Episode {
  Episode(this.title);
  final String title;
}

String label(Episode episode) => "Episode: ${episode.title}";
