//
//  TabBarItemsPreferenceKey.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation
import SwiftUI
import Resolver

struct TabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [TabBarItem] = []
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem] ) {
        value += nextValue()
    }
}

struct TabBarItemViewModifier: ViewModifier {
    let tab: TabBarItem
    @StateObject var viewModel: CustomTabBarViewModel = Resolver.resolve()

    func body(content: Content) -> some View {
        content
            .opacity(viewModel.selection == tab ? 1.0 : 0.0 )
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View {
    func tabBarItem(tab: TabBarItem) -> some View {
        modifier(TabBarItemViewModifier(tab: tab))
    }
}
