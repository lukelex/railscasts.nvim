defmodule RailscastsWeb.EpisodeLive.Show do
  use RailscastsWeb, :live_view

  def render(assigns) do
    ~H"""
    <article class="episode">
      <h1>{@episode.title}</h1>
    </article>
    """
  end
end
