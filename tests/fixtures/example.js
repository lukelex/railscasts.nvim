export function label(episode) {
  return episode.published ? `Episode: ${episode.title}` : "Draft"
}
