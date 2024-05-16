import Foundation

struct ModelResponse: Codable {
    let info: Info
    let results: [DatumModel]
    
    init(info: Info, results: [DatumModel]) {
        self.info = info
        self.results = results
    }
}

struct Info: Codable {
    let count, pages: Int
    let next: String
    let prev: JSONNull?

    init(count: Int, pages: Int, next: String, prev: JSONNull?) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}

struct Meta: Codable {
    let total: Int
    
    init(total: Int) {
        self.total = total
    }
}
