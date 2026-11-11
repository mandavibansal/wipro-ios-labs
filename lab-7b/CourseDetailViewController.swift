
import UIKit

class CourseDetailViewController: UIViewController {

    let course: Course

    let nameLabel = UILabel()
    let instructorLabel = UILabel()
    let durationLabel = UILabel()
    let descriptionLabel = UILabel()

    init(course: Course) {
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("This screen is created programmatically")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Course Details"
        view.backgroundColor = .white

        setupLabels()
        displayCourse()
    }

    func setupLabels() {

        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            instructorLabel,
            durationLabel,
            descriptionLabel
        ])

        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.font = .boldSystemFont(ofSize: 25)
        instructorLabel.font = .systemFont(ofSize: 18)
        durationLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.font = .systemFont(ofSize: 17)

        descriptionLabel.numberOfLines = 0

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 30
            ),

            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 25
            ),

            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -25
            )
        ])
    }

    func displayCourse() {

        nameLabel.text = course.name
        instructorLabel.text = "Instructor: \(course.instructor)"
        durationLabel.text = "Duration: \(course.duration)"
        descriptionLabel.text = course.description
    }
}
