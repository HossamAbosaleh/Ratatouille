# Ratatouille

An iOS recipe finder. You search for a dish, filter by diet, and see calories, weight and cooking time for each recipe.

## Features

- Splash and Get Started screens.
- Recipe search with a search bar.
- Diet filter chips: All, low-sugar, keto-friendly and vegan.
- Recipe list with images, loaded page by page using the API's next link.
- Details screen with calories, total weight and total time.
- Button to open the full recipe on the source website in Safari.
- Loading and empty states with Lottie animations, and a no connection screen.

## Built with

Swift, UIKit and storyboards, MVC, Alamofire, SDWebImage, lottie-ios, SwiftMessages. Data comes from the Edamam Recipe Search API.

## Running it

1. Run `pod install`.
2. Open `Ratatouille.xcworkspace` in Xcode.
3. You need your own Edamam app id and app key. Set them in `Ratatouille/Resources/Classes/Constants.swift`.
4. Build and run. The deployment target is iOS 13.

Learning project from January 2023.
