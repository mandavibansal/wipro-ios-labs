
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()

    let courses = [
        Course(
            name: "iOS Development",
            instructor: "John Smith",
            duration: "8 Weeks",
            description: "Learn to build iPhone applications using Swift and UIKit."
        ),
        Course(
            name: "Web Development",
            instructor: "Sarah Jones",
            duration: "6 Weeks",
            description: "Learn HTML, CSS and JavaScript to create websites."
        ),
        Course(
            name: "Python Programming",
            instructor: "David Brown",
            duration: "5 Weeks",
            description: "Learn Python programming and basic problem solving."
        ),
        Course(
            name: "Data Science",
            instructor: "Emily Davis",
            duration: "10 Weeks",
            description: "Learn data analysis, visualization and machine learning."
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Courses"
        view.backgroundColor = .white

        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "CourseCell"
        )

        view.addSubview(tableView)
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CourseCell",
            for: indexPath
        )

        let course = courses[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = course.name
        content.secondaryText = course.instructor

        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let selectedCourse = courses[indexPath.row]

        let detailVC = CourseDetailViewController(
            course: selectedCourse
        )

        navigationController?.pushViewController(
            detailVC,
            animated: true
        )
    }
}
