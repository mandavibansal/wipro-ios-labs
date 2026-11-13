import UIKit

class PostsViewController: UIViewController,
                           UITableViewDataSource,
                           UITableViewDelegate {

    let tableView = UITableView()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let statusLabel = UILabel()
    let retryButton = UIButton(type: .system)

    let apiService = APIService()

    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Posts"

        setupTableView()
        setupStatusView()
        fetchPosts()
    }

    func setupTableView() {

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "PostCell"
        )

        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),

            tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),

            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            )
        ])
    }

    func setupStatusView() {

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false

        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0

        retryButton.setTitle("Try Again", for: .normal)
        retryButton.addTarget(
            self,
            action: #selector(retryLoading),
            for: .touchUpInside
        )

        view.addSubview(activityIndicator)
        view.addSubview(statusLabel)
        view.addSubview(retryButton)

        NSLayoutConstraint.activate([

            activityIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            activityIndicator.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),

            statusLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            statusLabel.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),

            statusLabel.leadingAnchor.constraint(
                greaterThanOrEqualTo: view.leadingAnchor,
                constant: 20
            ),

            statusLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: view.trailingAnchor,
                constant: -20
            ),

            retryButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            retryButton.topAnchor.constraint(
                equalTo: statusLabel.bottomAnchor,
                constant: 15
            )
        ])

        statusLabel.isHidden = true
        retryButton.isHidden = true
    }

    func fetchPosts() {

        tableView.isHidden = true
        statusLabel.isHidden = true
        retryButton.isHidden = true

        activityIndicator.startAnimating()

        apiService.fetchPosts { [weak self] result in

            DispatchQueue.main.async {

                guard let self = self else { return }

                self.activityIndicator.stopAnimating()

                switch result {

                case .success(let fetchedPosts):

                    self.posts = fetchedPosts

                    if self.posts.isEmpty {
                        self.showEmptyState()
                    } else {
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                    }

                case .failure:

                    self.showErrorState()
                }
            }
        }
    }

    func showEmptyState() {

        tableView.isHidden = true
        statusLabel.text = "No posts available."
        statusLabel.isHidden = false
        retryButton.isHidden = true
    }

    func showErrorState() {

        tableView.isHidden = true
        statusLabel.text = "Unable to load posts. Please try again."
        statusLabel.isHidden = false
        retryButton.isHidden = false
    }

    @objc func retryLoading() {
        fetchPosts()
    }

    // MARK: - Table View

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return posts.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "PostCell",
            for: indexPath
        )

        let post = posts[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = post.title
        content.secondaryText = post.body
        content.secondaryTextProperties.numberOfLines = 2

        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        tableView.deselectRow(at: indexPath, animated: true)

        let selectedPost = posts[indexPath.row]

        let detailVC = DetailViewController()
        detailVC.post = selectedPost

        navigationController?.pushViewController(
            detailVC,
            animated: true
        )
    }
}
