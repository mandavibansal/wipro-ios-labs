import Foundation

class APIService {

    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {

        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(
                    domain: "No Data",
                    code: 0
                )))
                return
            }

            do {
                let posts = try JSONDecoder().decode(
                    [Post].self,
                    from: data
                )

                completion(.success(posts))

            } catch {
                completion(.failure(error))
            }

        }.resume()
    }
}