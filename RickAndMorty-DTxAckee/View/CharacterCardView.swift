//
//  CharacterCardView.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import SwiftUI
import CachedAsyncImage
import Resolver

struct CharacterCardView: View {
    // MARK: - Properties
    @StateObject var viewModel: CharacterCardViewModel
    // MARK: - Init
    init(for character: CharacterLocal) {
        _viewModel = StateObject(wrappedValue: Resolver.resolve(args: character))
    }
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top) {
            charactersImage
            charactersDetail
            Spacer()
            VStack {
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(16)
                    .padding(.leading, 80)
                Spacer()
            }
        }
        .background(Color.backgroundsSecondary)
        .frame(maxWidth: .infinity, minHeight: 60)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.15), radius: 16)
    }
}

// MARK: - Body Components
extension CharacterCardView {
    private var charactersImage: some View {
        CachedAsyncImage(url: URL(string: viewModel.character.imageUrl)) { image in
            image
                .resizable()
                .frame(maxWidth: 50, maxHeight: 50)
                .cornerRadius(10)
                .padding(8)
        } placeholder: {
            Color.clear
                .frame(maxWidth: 50, maxHeight: 50)
                .overlay(ProgressView())
                .padding(8)
        }
    }
    private var charactersDetail: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.character.name)
                    .font(.headline)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
                VStack {
                    if viewModel.character.isFavorite {
                        Image(Image.StringName.favoritesActive)
                            .resizable()
                            .colorMultiply(.iconsTertiary)
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                                                    .padding(.top, 6)
                        Spacer()
                    }
                }
            }
            Text(viewModel.character.status)
                .foregroundColor(.gray)
                .onTapGesture {
                    print(Image.StringName.favoritesActive)
                }
        }
        .padding(.vertical, 8)
    }
}
