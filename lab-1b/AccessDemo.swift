import Foundation
class AccessDemo{
    private var name = "Krish"
    
    fileprivate var age = 21
internal var course = "Btech CSE"
    
    public var university = "GLA"
    
    func displayDetails(){
        print("Name: \(name)")
        print("Age: \(age)")
        print("Course: \(course)")
        print("University: \(university)")
    }
}
