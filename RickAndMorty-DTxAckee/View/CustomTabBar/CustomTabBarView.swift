//
//  CustomTapBarView.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import SwiftUI
import Resolver

struct CustomTabBarView: View {
    
    //MARK: - Properties
    
    @StateObject var vm: CustomTabBarViewModel = Resolver.resolve()
    
    //MARK: - Body

    var body: some View {
        HStack {
            ForEach(vm.tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab)
                    }
            }
            .padding(.horizontal)
        }
        .padding(.horizontal, 10)
        .background(Color.backgroundsBottomNavigation)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.2), radius: 15)
    }
    
    //MARK: - Private Methods

    private func switchToTab(_ tab: TabBarItem) {
        withAnimation(.easeInOut) {
            vm.selection = tab
        }

    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView()
    }
}

//MARK: - CustomTabBarItem UI

extension CustomTabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(tab.iconName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 35, maxHeight: 35)
        }
        .colorMultiply(vm.selection == tab ? Color.iconsTertiary : Color.iconsSecondary)
        .padding(.vertical, 10)
        .cornerRadius(10)
    }
}
