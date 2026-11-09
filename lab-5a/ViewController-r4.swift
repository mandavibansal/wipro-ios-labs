
import UIKit

class ViewController: UIViewController {

    let statusLabel = UILabel()
    let startButton = UIButton(type: .system)
    let activityIndicator = UIActivityIndicatorView(style: .large)

    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        statusLabel.text = "Press Start"
        statusLabel.textAlignment = .center

        startButton.setTitle("Start", for: .normal)
        startButton.addTarget(
            self,
            action: #selector(startWork),
            for: .touchUpInside
        )

        activityIndicator.hidesWhenStopped = true

        let stack = UIStackView(
            arrangedSubviews: [
                statusLabel,
                activityIndicator,
                startButton
            ]
        )

        stack.axis = .vertical
        stack.spacing = 25
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func startWork() {

        if isLoading {
            return
        }

        isLoading = true

        startButton.isEnabled = false
        activityIndicator.startAnimating()

        statusLabel.text = "Loading..."

        DispatchQueue.global(qos: .userInitiated).async {

            sleep(3)

            DispatchQueue.global().asyncAfter(
                deadline: .now() + 2
            ) {

                DispatchQueue.main.async {

                    self.statusLabel.text = "Work Completed!"

                    self.activityIndicator.stopAnimating()

                    self.startButton.isEnabled = true

                    self.isLoading = false
                }
            }
        }
    }
}
