//
//  FavoriteCharactersView.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import SwiftUI
import Resolver

struct FavoriteCharactersView: View {
    
    // MARK: - Properties
    
    @StateObject var vm: FavoriteCharactersViewModel = Resolver.resolve()
    @Injected var customTabBarViewModel: CustomTabBarViewModel
    
    @State private var navigationTitle = "Favorites"

    // MARK: - Body 
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(vm.favoriteCharacters, id: \.id) { character in
                        NavigationLink {
                            CharactersDetailView(for: character)
                                .onAppear {
                                    withAnimation(.easeInOut) {
                                        navigationTitle = character.name
                                        customTabBarViewModel.isHidden = true
                                    }
                                }
                                .onDisappear {
                                    withAnimation(.easeInOut) {
                                        navigationTitle = "Favorites"
                                        customTabBarViewModel.isHidden = false
                                    }
                                }
                        } label: {
                            CharacterCardView(for: character)
                                .id(character.isFavorite)
                        }
                        .padding(.bottom, 8)
                    }
                }
            }
            .navigationTitle(navigationTitle)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .tint(.foregroundsPrimary)
    }
}

struct FavoriteCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCharactersView()
    }
}
