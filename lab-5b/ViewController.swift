import UIKit

class ViewController: UIViewController {

    let titleLabel = UILabel()
    let statusLabel = UILabel()
    let productsLabel = UILabel()

    let successButton = UIButton(type: .system)
    let emptyButton = UIButton(type: .system)
    let failureButton = UIButton(type: .system)
    let cancelButton = UIButton(type: .system)

    var fetchTask: Task<Void, Never>?

    enum FetchType {
        case success
        case empty
        case failure
    }

    enum FetchError: Error {
        case serverError
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupUI()
    }

    func setupUI() {

        titleLabel.text = "Product Store"
        titleLabel.font = .boldSystemFont(ofSize: 26)
        titleLabel.textAlignment = .center

        statusLabel.text = "Choose an option to fetch products"
        statusLabel.font = .systemFont(ofSize: 17)
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0

        productsLabel.text = ""
        productsLabel.font = .systemFont(ofSize: 18)
        productsLabel.numberOfLines = 0
        productsLabel.textAlignment = .center

        successButton.setTitle("Fetch Products", for: .normal)
        emptyButton.setTitle("Fetch Empty List", for: .normal)
        failureButton.setTitle("Simulate Failure", for: .normal)
        cancelButton.setTitle("Cancel Fetch", for: .normal)

        successButton.addTarget(self, action: #selector(fetchSuccess), for: .touchUpInside)
        emptyButton.addTarget(self, action: #selector(fetchEmpty), for: .touchUpInside)
        failureButton.addTarget(self, action: #selector(fetchFailure), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelFetch), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            statusLabel,
            productsLabel,
            successButton,
            emptyButton,
            failureButton,
            cancelButton
        ])

        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
    }

// R1
    func fetchProducts(type: FetchType) async throws -> [String] {

        try await Task.sleep(nanoseconds: 4_000_000_000)

        try Task.checkCancellation()

        switch type {

        case .success:
            return ["Laptop", "Mobile", "Headphones", "Keyboard"]

        case .empty:
            return []

        case .failure:
            throw FetchError.serverError
        }
    }

//R2 , R3
    @MainActor
    func startFetching(type: FetchType) {
        guard fetchTask == nil else {
            statusLabel.text = "A fetch is already running."
            return
        }
        fetchTask?.cancel()

        statusLabel.text = "Loading products..."
        productsLabel.text = ""

        fetchTask = Task {

            do {

                let products = try await fetchProducts(type: type)

                if products.isEmpty {
                    statusLabel.text = "No products found."
                    productsLabel.text = ""
                } else {
                    statusLabel.text = "Products fetched successfully!"

                    productsLabel.text = products
                        .map { "• \($0)" }
                        .joined(separator: "\n")
                }

            } catch is CancellationError {

                statusLabel.text = "Fetch cancelled."
                productsLabel.text = ""

            } catch {

                statusLabel.text = "Something went wrong. Please try again."
                productsLabel.text = ""
            }

            fetchTask = nil
        }
    }

    @objc func fetchSuccess() {
        startFetching(type: .success)
    }

    @objc func fetchEmpty() {
        startFetching(type: .empty)
    }

    @objc func fetchFailure() {
        startFetching(type: .failure)
    }
//R4
    @objc func cancelFetch() {

        guard let task = fetchTask else {
            statusLabel.text = "No active fetch to cancel."
            return
        }

        task.cancel()
    }
}

