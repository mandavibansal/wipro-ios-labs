import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    let scrollView = UIScrollView()
    let mainStack = UIStackView()

    let nameField = UITextField()
    let courseSegment = UISegmentedControl(items: ["iOS", "Android", "Web"])

    let weekendSwitch = UISwitch()
    let hoursSlider = UISlider()

    let datePicker = UIDatePicker()

    let summaryLabel = UILabel()
    let submitButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad called")

        title = "Course Registration"
        view.backgroundColor = .systemBackground

        setupUI()
        setupKeyboardHandling()
        updateSummary()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear called")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear called")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear called")
    }

    func setupUI() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        mainStack.axis = .vertical
        mainStack.spacing = 18
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            mainStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            mainStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            mainStack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40)
        ])

        let heading = UILabel()
        heading.text = "Course Registration Form"
        heading.font = .boldSystemFont(ofSize: 24)

        mainStack.addArrangedSubview(heading)

        nameField.placeholder = "Enter your name"
        nameField.borderStyle = .roundedRect
        nameField.delegate = self
        nameField.addTarget(self, action: #selector(controlChanged), for: .editingChanged)

        mainStack.addArrangedSubview(makeLabel("Student Name"))
        mainStack.addArrangedSubview(nameField)

        courseSegment.selectedSegmentIndex = 0
        courseSegment.addTarget(self, action: #selector(controlChanged), for: .valueChanged)

        mainStack.addArrangedSubview(makeLabel("Select Course"))
        mainStack.addArrangedSubview(courseSegment)

        let switchRow = UIStackView()
        switchRow.axis = .horizontal
        switchRow.distribution = .equalSpacing

        let switchLabel = UILabel()
        switchLabel.text = "Weekend Classes"

        switchRow.addArrangedSubview(switchLabel)
        switchRow.addArrangedSubview(weekendSwitch)

        weekendSwitch.addTarget(self, action: #selector(controlChanged), for: .valueChanged)

        mainStack.addArrangedSubview(switchRow)

        hoursSlider.minimumValue = 1
        hoursSlider.maximumValue = 10
        hoursSlider.value = 5
        hoursSlider.addTarget(self, action: #selector(controlChanged), for: .valueChanged)

        mainStack.addArrangedSubview(makeLabel("Daily Study Hours"))
        mainStack.addArrangedSubview(hoursSlider)

        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(controlChanged), for: .valueChanged)

        mainStack.addArrangedSubview(makeLabel("Starting Date"))
        mainStack.addArrangedSubview(datePicker)

        let summaryView = UIView()
        summaryView.backgroundColor = .secondarySystemBackground
        summaryView.layer.cornerRadius = 12

        summaryLabel.numberOfLines = 0
        summaryLabel.font = .systemFont(ofSize: 16)

        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryView.addSubview(summaryLabel)

        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: 15),
            summaryLabel.bottomAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: -15),
            summaryLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: 15),
            summaryLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -15)
        ])

        mainStack.addArrangedSubview(makeLabel("Registration Summary"))
        mainStack.addArrangedSubview(summaryView)

        submitButton.setTitle("Submit Registration", for: .normal)
        submitButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        submitButton.addTarget(self, action: #selector(submitForm), for: .touchUpInside)

        mainStack.addArrangedSubview(submitButton)
    }

    func makeLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }

    @objc func controlChanged() {
        updateSummary()
    }

    func updateSummary() {

        let name = nameField.text?.isEmpty == false
            ? nameField.text!
            : "Not entered"

        let course = courseSegment.titleForSegment(
            at: courseSegment.selectedSegmentIndex
        ) ?? "None"

        let weekend = weekendSwitch.isOn ? "Yes" : "No"

        let hours = Int(hoursSlider.value)

        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        let date = formatter.string(from: datePicker.date)

        summaryLabel.text = """
        Student: \(name)

        Course: \(course)

        Weekend Classes: \(weekend)

        Study Hours: \(hours) hours

        Starting Date: \(date)
        """
    }

    @objc func submitForm() {

        let summaryScreen = SummaryViewController()
        summaryScreen.registrationDetails = summaryLabel.text ?? ""

        navigationController?.pushViewController(
            summaryScreen,
            animated: true
        )
    }

    func setupKeyboardHandling() {

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func keyboardWillShow(notification: Notification) {

        if let keyboardFrame = notification.userInfo?[
            UIResponder.keyboardFrameEndUserInfoKey
        ] as? CGRect {

            scrollView.contentInset.bottom = keyboardFrame.height
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.height
        }
    }

    @objc func keyboardWillHide(notification: Notification) {

        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class SummaryViewController: UIViewController {

    var registrationDetails = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Summary Screen: viewDidLoad called")

        title = "Registration Details"
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.text = registrationDetails
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Summary Screen: viewWillAppear called")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Summary Screen: viewDidAppear called")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Summary Screen: viewWillDisappear called")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Summary Screen: viewDidDisappear called")
    }
}