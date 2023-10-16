//
//  TabBarItem.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import SwiftUI

enum TabBarItem {
    case allCharacters, favouriteCharacters
    
    var iconName: String{
        switch self {
        case .allCharacters:
            return Image.StringName.tabBarAllCharacters
        case .favouriteCharacters:
            return Image.StringName.tabBarFavoriteCharacters
        }
    }
}
