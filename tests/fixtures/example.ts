// A Railscasts-style TypeScript fixture
interface Episode {
  title: string
  published: boolean
}

export function label(episode: Episode): string {
  return episode.published ? `Episode: ${episode.title}` : "Draft"
}
