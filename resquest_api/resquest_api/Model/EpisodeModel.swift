import Foundation

struct EpisodeModel: Codable, Identifiable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    init(id: Int, name: String, airDate: String, episode: String, characters: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.airDate = airDate
        self.episode = episode
        self.characters = characters
        self.url = url
        self.created = created
    }
}
