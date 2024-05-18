import SwiftUI

class ViewModel: ObservableObject {
    @Published var data: [DatumModel] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var hasData: Bool = false
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    @MainActor
    func getData(page: Int) async {
        isLoading = true
        do {
            data = try await networkService.fetchData(page: page)
            hasData = true
        } catch {
            isLoading = false
            print(error.localizedDescription)
        }
    }
}
