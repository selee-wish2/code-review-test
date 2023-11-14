import Foundation

class MyModel: Codable {
    let items:[item]
}

class item: Codable {
    let score: Int
}


struct MyRowViewModel {
    var title: String
    init(with model: item) {
        title = String(model.score)
    }
}


