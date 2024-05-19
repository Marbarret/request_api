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
    
    func fetchDataDetail() async throws -> [DatumModel] {
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
          let dataResult = try decoder.decode(ModelResponse.self, from: data) // Replace with your actual response model type

          // Process episode URLs within characters
          var charactersWithEpisodes: [DatumModel] = []
          for character in dataResult.results {
            var updatedCharacter = character
            updatedCharacter.episode = [] // Initialize empty episode array

            if let episodeUrls = character.episode {
              // Fetch episode details asynchronously (optional)
              var episodeDetails: [EpisodeModel] = []
              for episodeUrl in episodeUrls {
                let episodeData = try await fetchEpisodeDetails()
                if let episode = episodeData {
                  episodeDetails.append(episode)
                }
              }
              updatedCharacter.episode = episodeDetails // Update character with fetched episode details
            }
            charactersWithEpisodes.append(updatedCharacter)
          }

          return charactersWithEpisodes
    }
    
    private func fetchEpisodeDetails() async throws -> EpisodeModel? {
      // Implement logic to fetch data from episodeUrl and decode into EpisodeModel (similar to fetchData)
      // Return decoded EpisodeModel or nil if there's an error
    }
}
