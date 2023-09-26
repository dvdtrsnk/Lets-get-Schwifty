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
    
    @StateObject var vm: CharacterCardViewModel
    
    // MARK: - Init
    init(for character: CharacterLocal) {
        _vm = StateObject(wrappedValue: Resolver.resolve(args: character))
    }
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top) {
            CachedAsyncImage(url: URL(string:vm.character.imageUrl)) { image in
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
            
            VStack(alignment: .leading) {
                HStack {
                    Text(vm.character.name)
                        .font(.headline)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                    
                    VStack {
                        if vm.character.isFavorite {
                            Image(Image.StringName.favorites_Active)
                                .resizable()
                                .colorMultiply(.iconsTertiary)
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                                        .padding(.top, 6)
                            Spacer()
                        }
                    }
                }
                
                Text(vm.character.status)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        print(Image.StringName.favorites_Active)
                    }
            }
            .padding(.vertical, 8)
            
            Spacer()
            
            VStack{
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

//struct CharacterCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        let character: Character = Bundle.main.decodeCharacters("mockDataLocal.json").first!
//        CharacterCardView(for: character)
//    }
//}
