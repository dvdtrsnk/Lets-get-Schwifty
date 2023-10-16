//
//  CharactersDetailView.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import SwiftUI
import Resolver

struct CharactersDetailView: View {
    // MARK: - Properties
    @StateObject var viewModel: CharactersDetailViewModel
    // MARK: - Init
    init(for character: CharacterLocal) {
        _viewModel = StateObject(wrappedValue: Resolver.resolve(args: character))
    }
    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        AsyncImage(url: URL(string: viewModel.character.imageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140, height: 140, alignment: .topLeading)
                                .cornerRadius(10)
                        } placeholder: {
                            Color.clear
                                .frame(width: 140, height: 140, alignment: .topLeading)
                                .overlay(ProgressView())
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Name")
                                Spacer()
                                Button {
                                    Task {
                                        await viewModel.switchIsFavorite()
                                    }
                                } label: {
                                    Image(viewModel.isFavorite ?
                                          Image.StringName.favoritesActive : Image.StringName.favoritesInactive)
                                        .resizable()
                                        .scaledToFit()
                                        .colorMultiply(.iconsTertiary)
                                        .frame(width: 32, height: 32)
                                }
                            }
                            Text(viewModel.character.name)
                                .lineLimit(3)
                                .padding(.top, 8)
                                .font(.headline)
                            Spacer()
                        }
                        .padding(.leading, 16)
                        Spacer()
                    }
                    .padding(16)
                    Divider()
                        .padding(.bottom, 24)
                    descriptionLine(category: "Status", info: viewModel.character.status.slashIfEmpty())
                    descriptionLine(category: "Species", info: viewModel.character.species.slashIfEmpty())
                    descriptionLine(category: "Type", info: viewModel.character.type.slashIfEmpty())
                    descriptionLine(category: "Gender", info: viewModel.character.gender.slashIfEmpty())
                    descriptionLine(category: "Origin", info: viewModel.character.originName.slashIfEmpty())
                    descriptionLine(category: "Location", info: viewModel.character.originName.slashIfEmpty())
                }
                .frame(maxWidth: .infinity)
                .background(Color.backgroundsSecondary)
                .cornerRadius(20)
                .padding(8)
                .shadow(color: .black.opacity(0.2), radius: 16)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - DescriptionLine View

extension CharactersDetailView {
    private func descriptionLine(category: String, info: String) -> some View {
        HStack {
            Text(category)
                .frame(maxWidth: 85, alignment: .leading)
                .multilineTextAlignment(.leading)
            Text(info)
                .font(.headline)
                .frame(alignment: .leading)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding([.bottom, .horizontal], 24)
    }
}
