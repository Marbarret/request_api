import Foundation

enum APIManager {
    case endPointRequest //endpoint da api
}

extension APIManager {
    var accessToken: String {
        return ""
    }
    
    var baseUrl: String {
        return "https://rickandmortyapi.com/api"
    }
    
    var path: String {
        switch self {
        case .endPointRequest:
            return "/character"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .endPointRequest:
            return .get
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .endPointRequest:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
}
