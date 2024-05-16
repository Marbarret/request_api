import Foundation

enum APIManager {
    case topRated
    
    public init(topRatedMovies: Void) {
        self = .topRated
    }
}

extension APIManager {
    var accessToken: String {
        return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMjQ5NGQ4NGVmZWZlMzYyNmM0OGQzODUyMDZmMWI4MSIsInN1YiI6IjYxOTE2YjJlOTU3ZTZkMDA2MGFiODYzMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3_BxuihJCbVZwsebANM0WeGoiyy8rD4JCJDSt6RIa34"
    }
    
    var baseUrl: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var path: String {
        switch self {
        case .topRated:
            return "movie/popular"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .topRated:
            return .get
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .topRated:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
}
