defmodule Episode do
  @type status :: :draft | :published

  def label(%{title: title}), do: "Episode: #{title}"
end
