#[derive(Debug)]
struct Episode {
    title: String,
    published: bool,
}

impl Episode {
    fn label(&self) -> String {
        format!("Episode: {}", self.title)
    }
}
