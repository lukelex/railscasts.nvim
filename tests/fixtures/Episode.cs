public record Episode(string Title, bool Published)
{
    public string Label() => $"Episode: {Title}";
}
