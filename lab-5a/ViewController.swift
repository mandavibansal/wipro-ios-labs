
import UIKit

class ViewController: UIViewController {

    let statusLabel = UILabel()
    let startButton = UIButton(type: .system)

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

        let stack = UIStackView(
            arrangedSubviews: [statusLabel, startButton]
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

        statusLabel.text = "Working..."

        DispatchQueue.global().async {

            sleep(3)

            DispatchQueue.main.async {
                self.statusLabel.text = "Work Completed!"
            }
        }
    }
}
