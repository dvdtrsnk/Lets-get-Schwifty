# Lets-get-Schwifty

## Overview
This is a SwiftUI-based iOS application that follows the MVVM architectural pattern. It retrieves data from APIs using async functions in the CharactersRepository (via NetworkManager) and stores it in CoreData using the LocalDataManager.

## Background
Due to the extensive nature of the API, data is fetched and updated in small time intervals, page by page. This ensures that each subsequent launch of the app refreshes the data while seamlessly presenting the user with cached content. Users can interact with the app without noticing the background data update process.

## Key Features
- **MVVM Architecture**

- **Custom TabBar:** With similar using like native TabBar.

- **Caching:** Using CoreData for caching data, allowing for fast retrieval and seamless updates.

- **Image Optimization:** To reduce downloaded data volume, the app makes use of "SwiftUI Cached async image" for efficient image loading.

- **Dependency Injection:** Dependency injection is handled using the Resolver library, ensuring modularity and testability.

- **Unit Tests:** Unit tests that are using Mock Objects injected via Resolver and Protocols (Dependency Inversion Principle.


## Dependencies
- [Resolver](https://github.com/hmlongco/Resolver): Dependency injection library used to manage dependencies.

- ["SwiftUI Cached async image"](https://github.com/lorenzofiamingo/swiftui-cached-async-image): A utility for cached image loading in SwiftUI.


## Architectural Structure (MVVM) 

![Graphviz](https://github.com/dvdtrsnk/Lets-get-Schwifty/blob/main/graphviz.png)

