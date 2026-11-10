
import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case networkFailure
    case httpError(Int)
    case decodingFailure
    case emptyResults

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid API URL."
        case .networkFailure:
            return "Network connection failed. Please try again."
        case .httpError(let code):
            return "Server error. Status code: \(code)"
        case .decodingFailure:
            return "Unable to read the server response."
        case .emptyResults:
            return "No posts found."
        }
    }
}

class PostService {

    func fetchPosts() async throws -> [Post] {

        // Create URL using URLComponents
        var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        components.path = "/posts"

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        // Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 15

        // Fetch data from API
        let data: Data

        do {
            let (responseData, response) =
                try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.networkFailure
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.httpError(httpResponse.statusCode)
            }

            data = responseData

        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkFailure
        }

        // Decode JSON response
        let posts: [Post]

        do {
            posts = try JSONDecoder().decode(
                [Post].self,
                from: data
            )
        } catch {
            throw APIError.decodingFailure
        }

        // Check for empty results
        guard !posts.isEmpty else {
            throw APIError.emptyResults
        }

        return posts
    }
}
