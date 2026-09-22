public record Episode(String title, boolean published) {
  String label() {
    return "Episode: " + title;
  }
}
