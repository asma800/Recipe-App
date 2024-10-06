import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []

    func loadRecipesFromFile() {
        // Check for the URL of the recipes.json file
        if let url = Bundle.main.url(forResource: "recipes", withExtension: "json") {
            print("URL to JSON file: \(url)") // This will print the URL in the console
            

            
            do {
                // Load the data from the file
                let data = try Data(contentsOf: url)
                
                // Decode the JSON data into a RecipeResponse object
                let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                
                // Update the recipes array on the main thread
                DispatchQueue.main.async {
                    self.recipes = decodedResponse.recipes
                    print("Successfully loaded \(self.recipes.count) recipes.") // Optional: log number of recipes loaded
                }
            } catch {
                // Print a detailed error message
                print("Error loading or decoding JSON: \(error.localizedDescription)")
            }
        } else {
            print("Error: Could not find recipes.json file.")
        }
    }
}
