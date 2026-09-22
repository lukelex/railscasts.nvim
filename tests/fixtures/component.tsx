type Episode = { title: string; published: boolean }

export function EpisodeLabel({ episode }: { episode: Episode }) {
  return <span className="episode">{episode.title}</span>
}
