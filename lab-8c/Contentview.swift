
import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = CourseViewModel()
    @State private var searchText = ""

    var filteredCourses: [Int] {
        viewModel.courses.indices.filter { index in
            searchText.isEmpty ||
            viewModel.courses[index].title.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {

            List {
                ForEach(filteredCourses, id: \.self) { index in

                    NavigationLink {
                        CourseDetailView(
                            course: $viewModel.courses[index]
                        )
                    } label: {
                        CourseCardView(
                            course: viewModel.courses[index],
                            isFavourite: $viewModel.courses[index].isFavourite
                        )
                    }
                }
            }
            .navigationTitle("Course Explorer")
            .searchable(text: $searchText, prompt: "Search courses")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        FavouritesView(viewModel: viewModel)
                    } label: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}
