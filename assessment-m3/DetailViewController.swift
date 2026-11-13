
import UIKit

class DetailViewController: UIViewController {

    var post: Post?

    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    let userLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Post Details"

        setupUI()
        displayPost()
    }

    func setupUI() {

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0

        bodyLabel.font = .systemFont(ofSize: 17)
        bodyLabel.numberOfLines = 0

        userLabel.font = .systemFont(ofSize: 14)
        userLabel.textColor = .secondaryLabel

        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            userLabel,
            bodyLabel
        ])

        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([

            stack.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 30
            ),

            stack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 25
            ),

            stack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -25
            )
        ])
    }

    func displayPost() {

        guard let post = post else {
            return
        }

        titleLabel.text = post.title
        bodyLabel.text = post.body
        userLabel.text = "Post ID: \(post.id) | User ID: \(post.userId)"
    }
}
