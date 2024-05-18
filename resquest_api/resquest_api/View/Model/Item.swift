import SwiftUI

struct Item: Identifiable {
    var id: UUID = .init()
    var color: Color
}

var itemData: [Item] = [
    .init(color: .red),
    .init(color: .blue),
    .init(color: .gray),
    .init(color: .green),
    .init(color: .yellow),
    .init(color: .cyan),
    .init(color: .black),
    .init(color: .pink)
]
