# Product Listing App

This is a simple Flutter application (version 3.19.3) that allows users to browse and search for products. It fetches product data from the [FakeStoreAPI](https://fakestoreapi.com/docs) and provides features such as sign-in, product listing, search, product details, and cart management.

## Features

1. **Sign In Screen:** Users can sign in to the app.
2. **Product Listing:** Displays a list of products fetched from the API.
3. **Search:** Enables users to search for products.
4. **Product Details:** Shows detailed information about a selected product.
5. **My Cart:** Allows users to manage their shopping cart.

## Project Structure

The project is structured as follows:

- `lib/`: Contains the Dart code for the application.

  - `app/`: Contains global code that can be shared at the entire of project.
    - `route/`: Manages navigation routes for the entire application.
    - `shared/`: Contains shared resources, utilities, and constants for global use.
    - `widget/`: Houses reusable UI components that can be used across different features.
    - `service/`: Provides global services and utilities used throughout the application.
  - `features/`: Directory for organizing features of the application.
    - `bloc/`: BLoC classes for specific features.
    - `model/`: Includes models specific to each feature.
    - `service/`: Services specific to each feature, such as API calls.
    - `view/`: User interface components specific to each feature.

- `test/`: Unit tests

## How to Run

1. Clone the repository: `git clone <repository-url>`
2. Navigate to the project directory: `cd product_listing_app`
3. Run `flutter pub get` to install dependencies.
4. Run `flutter run` to launch the app on your device or emulator.

## Usage

After installing the application, you can log in with the following credentials:
- Username: `mor_2314`
- Password: `83r5^_`
