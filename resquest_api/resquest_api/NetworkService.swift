import Foundation
import Combine

class NetworkService {
    
    private let session: URLSession
    private let apiManager: APIManager
    
    init(session: URLSession = URLSession.shared, apiManager: APIManager) {
        self.session = session
        self.apiManager = apiManager
    }
    
    func getRatedMovie() async throws -> [MovieModel] {
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
        return try decoder.decode([MovieModel].self, from: data)
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
