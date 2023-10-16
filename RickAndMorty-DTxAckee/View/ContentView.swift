//
//  ContentView.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import SwiftUI

struct ContentView: View {
        // MARK: - Body
    var body: some View {
        VStack {
            CustomTabBarContainerView {
                CharactersView()
                    .tabBarItem(tab: .allCharacters)
                FavoriteCharactersView()
                    .tabBarItem(tab: .favouriteCharacters)
            }
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
