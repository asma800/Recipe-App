//
//  Recipe_appTests.swift
//  Recipe appTests
//
//  Created by Asma on 10/5/24.
//

import XCTest
@testable import Recipe_app

final class Recipe_appTests: XCTestCase {

var testRecipes: [Recipe] = []
    
    override func setUp() {
        super.setUp()
        if let url = Bundle.main.url(forResource: "recipes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                testRecipes = decodedResponse.recipes
            } catch {
                XCTFail("Failed to decode JSON file: \(error.localizedDescription)")
            }
        } else {
            XCTFail("Could not find test recipes.json file.")
        }
    }
    
    func testRecipeIntegrity() {
        for recipe in testRecipes {
            XCTAssertFalse(recipe.cuisine.isEmpty, "Recipe is missing a cuisine.")
            XCTAssertFalse(recipe.name.isEmpty, "Recipe is missing a name.")
            XCTAssertFalse(recipe.uuid.isEmpty, "Recipe is missing a UUID.")
        }
    }
    
    func testRecipesArrayNotEmpty() {
        XCTAssertFalse(testRecipes.isEmpty, "Recipes array should not be empty.")
    }
        
    func testRecipePhotoURL() {
        for recipe in testRecipes {
            guard let photoURL = URL(string: recipe.photo_url_large) else {
                XCTFail("Invalid photo URL for recipe: \(recipe.name)")
                continue
            }
            
            XCTAssertTrue(photoURL.scheme == "https", "Recipe photo URL is not secure (https).")
        }
    }
}
