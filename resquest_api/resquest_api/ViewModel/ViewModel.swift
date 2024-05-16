import SwiftUI

class ViewModel: ObservableObject {
    @Published private(set) var movies: [DatumModel] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: Error?
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    @MainActor
    func getData(page: Int) async {
        do {
            movies = try await networkService.fetchData(page: page)
        } catch {
            print(error.localizedDescription)
        }
    }
}
