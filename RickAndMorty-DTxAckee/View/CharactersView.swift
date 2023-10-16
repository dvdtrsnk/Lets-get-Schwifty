//
//  CharactersView.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import SwiftUI
import Resolver

struct CharactersView: View {
    // MARK: - Properties
    @State var navigationTitle = "Characters"
    @StateObject var viewModel: CharactersViewModel = Resolver.resolve()
    @Injected var customTabBarViewModel: CustomTabBarViewModel

    // MARK: - Body 
    var body: some View {
        ZStack {
            Color.backgroundsPrimary
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            NavigationView {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.charactersFiltered, id: \.id) { character in
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
                                            navigationTitle = "Characters"
                                            customTabBarViewModel.isHidden = false
                                        }
                                    }
                            } label: {
                                CharacterCardView(for: character)
                                    .id(character.isFavorite)
                            }
                            .padding(8)
                        }
                    }
                }
                .navigationTitle(navigationTitle)
                .searchable(text: $viewModel.searchField, prompt: "Search character")
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    customTabBarViewModel.isHidden = true
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    customTabBarViewModel.isHidden = false
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tint(.foregroundsPrimary)
        }
        .onAppear {
            Task {
                await viewModel.charactersRepository.updateAllCharactersNetworkToLocal()
            }
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
