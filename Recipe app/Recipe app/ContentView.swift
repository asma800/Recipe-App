import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = RecipeViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    if viewModel.recipes.isEmpty {
                        Text("Loading recipes...")
                    } else {
                        ForEach(viewModel.recipes.indices, id: \.self) { index in
                            Text(viewModel.recipes[index].name)
                                .bold()
                            AsyncImage(url: URL(string: viewModel.recipes[index].photo_url_small)) { image in image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView() // Shows a loading spinner
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.loadRecipesFromFile()
                }
            }
            .padding()
            .navigationTitle("Recipes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
