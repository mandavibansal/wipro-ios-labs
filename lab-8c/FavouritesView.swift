
import SwiftUI

struct FavouritesView: View {

    @ObservedObject var viewModel: CourseViewModel

    var body: some View {
        List {
            ForEach($viewModel.courses) { $course in

                if course.isFavourite {
                    NavigationLink {
                        CourseDetailView(course: $course)
                    } label: {
                        CourseCardView(
                            course: course,
                            isFavourite: $course.isFavourite
                        )
                    }
                }
            }
        }
        .navigationTitle("My Favourites")
    }
}
