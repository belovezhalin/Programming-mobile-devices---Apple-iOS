# Instafilter

A photo editing app that integrates **Core Image** with SwiftUI, allowing users to apply filters and share images.

## 🛠 Features
- Load images from the **Photos Library**
- Apply **Core Image** filters
- Adjust filters dynamically using **confirmationDialog()**
- Share edited images with **ShareLink**
- Request App Store reviews within the app

## 📌 Key Learnings
- Understanding how **property wrappers** like `@State` behave as structs
- Using `onChange()` to respond to state changes
- Displaying multiple options with **confirmationDialog()**
- Working with **Core Image** for image processing
- Using **ContentUnavailableView** to handle empty states
- Importing images with **PhotosPicker**
- Requesting user feedback with **StoreKit**
