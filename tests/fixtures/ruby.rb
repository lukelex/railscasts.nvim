# A Railscasts-style Ruby fixture
class Episode
  def initialize(title, published: true)
    @title = title
    @published = published
  end

  def label
    return :draft unless @published

    "Episode: #{@title}"
  end
end
