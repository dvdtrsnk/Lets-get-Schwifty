//
//  TabBarViewModel.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import SwiftUI

class CustomTabBarViewModel: ObservableObject {
    // MARK: - Properties
    @Published var tabs: [TabBarItem] = []
    @Published var isHidden: Bool = false
    @Published var selection: TabBarItem = .allCharacters
}
