import Foundation
import UIKit

class NetworkService {
    
    private let session: URLSession
    private let apiManager: APIManager
    
    init(session: URLSession = URLSession.shared, apiManager: APIManager) {
        self.session = session
        self.apiManager = apiManager
    }
    
    func fetchData(page: Int) async throws -> [DatumModel] {
        guard let url = URL(string: apiManager.baseUrl + apiManager.path) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiManager.method.rawValue
        urlRequest.allHTTPHeaderFields = apiManager.header
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.unexpectedStatusCode
        }
        
        let decoder = JSONDecoder()
        let dataResult = try decoder.decode(ModelResponse.self, from: data)
        return dataResult.results
    }
}
