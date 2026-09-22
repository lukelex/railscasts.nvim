data class Episode(val title: String)

fun label(episode: Episode): String = "Episode: ${episode.title}"
