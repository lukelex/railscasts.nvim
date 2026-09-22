from dataclasses import dataclass


@dataclass
class Episode:
    title: str
    published: bool = True

    def label(self) -> str:
        return f"Episode: {self.title}" if self.published else "Draft"
