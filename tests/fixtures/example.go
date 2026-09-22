package episode

type Episode struct {
	Title     string
	Published bool
}

func (episode Episode) Label() string {
	return "Episode: " + episode.Title
}
