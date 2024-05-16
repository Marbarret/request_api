import Foundation
import Combine

class NetworkService {
    
    private let session: URLSession
    private let apiManager: APIManager
    
    init(session: URLSession = URLSession.shared, apiManager: APIManager) {
        self.session = session
        self.apiManager = apiManager
    }
    
    func fetchData(page: Int) async throws -> [MovieModel] {
        var urlComponents = URLComponents(string: apiManager.baseUrl + apiManager.path)!
        
        urlComponents.queryItems = [
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: String(page)),
          URLQueryItem(name: "sort_by", value: "created_at.asc"),
        ]
        
        guard let url = urlComponents.url else {
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

enum NetworkError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
