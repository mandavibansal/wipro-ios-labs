
import UIKit

class FormViewController: UIViewController {

    let nameField = UITextField()
    let emailField = UITextField()
    let messageField = UITextField()
    let submitButton = UIButton(type: .system)
    let errorLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Registration"

        setupForm()
    }

    func setupForm() {

        let heading = UILabel()
        heading.text = "Registration Form"
        heading.font = .boldSystemFont(ofSize: 26)

        nameField.placeholder = "Enter your name"
        nameField.borderStyle = .roundedRect
        nameField.autocapitalizationType = .words

        emailField.placeholder = "Enter your email"
        emailField.borderStyle = .roundedRect
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none

        messageField.placeholder = "Enter your message"
        messageField.borderStyle = .roundedRect

        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        submitButton.addTarget(
            self,
            action: #selector(submitForm),
            for: .touchUpInside
        )

        errorLabel.textColor = .systemRed
        errorLabel.font = .systemFont(ofSize: 14)
        errorLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [
            heading,
            nameField,
            emailField,
            messageField,
            errorLabel,
            submitButton
        ])

        stack.axis = .vertical
        stack.spacing = 18
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 25
            ),

            stack.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -25
            ),

            stack.centerYAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.centerYAnchor
            ),

            nameField.heightAnchor.constraint(equalToConstant: 48),
            emailField.heightAnchor.constraint(equalToConstant: 48),
            messageField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    @objc func submitForm() {

        let name = nameField.text ?? ""
        let email = emailField.text ?? ""
        let message = messageField.text ?? ""

        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            errorLabel.text = "Please enter your name."
            return
        }

        if !isValidEmail(email) {
            errorLabel.text = "Please enter a valid email."
            return
        }

        if message.trimmingCharacters(in: .whitespaces).isEmpty {
            errorLabel.text = "Please enter a message."
            return
        }

        errorLabel.text = ""

        let postsVC = PostsViewController()
        navigationController?.pushViewController(
            postsVC,
            animated: true
        )
    }

    func isValidEmail(_ email: String) -> Bool {

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        return email.range(
            of: emailFormat,
            options: .regularExpression
        ) != nil
    }
}
