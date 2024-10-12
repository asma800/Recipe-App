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
                            let recipe = viewModel.recipes[index]
                            
                            VStack {
                                Text(recipe.name)
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                                    .font(.title)
                                    .padding(2)
                                Text(recipe.cuisine)
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.center)
                                AsyncImage(url: URL(string: recipe.photo_url_large)) { image in image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView() // Shows a loading spinner
                                }
                                if let sourceURL = recipe.source_url, !sourceURL.isEmpty {
                                    Link("View Recipe", destination: URL(string: sourceURL)!)
                                        .foregroundColor(.blue)
                                        .font(.system(size: 18))
                                        .frame(maxWidth: .infinity)
                                        .multilineTextAlignment(.center)
                                        .padding(1)

                                }
                                if let videoURL = recipe.youtube_url, !videoURL.isEmpty {
                                    Link("Watch Video", destination: URL(string: videoURL)!)
                                        .foregroundColor(.blue)
                                        .font(.system(size: 18))
                                        .frame(maxWidth: .infinity)
                                        .multilineTextAlignment(.center)
                                        .padding(1)
                                }
                            }
                            .padding()
                            .background(Color(red: 193/255, green: 227/255, blue: 226/255))
                            .cornerRadius(10)
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
