import Foundation

protocol ApiService {
    associatedtype T: Decodable

    func get(endpoint: String, headers: [String: String], completion: @escaping (Result<T, Error>) -> Void)
    func post(endpoint: String, headers: [String: String], body: String, completion: @escaping (Result<T, Error>) -> Void)
    func put(endpoint: String, headers: [String: String], body: String, completion: @escaping (Result<T, Error>) -> Void)
    func delete(endpoint: String, headers: [String: String], completion: @escaping (Result<Void, Error>) -> Void)
}
