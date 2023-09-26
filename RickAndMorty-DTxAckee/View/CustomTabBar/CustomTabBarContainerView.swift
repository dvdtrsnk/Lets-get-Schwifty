//
//  CustomTabBarContainerView.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import SwiftUI
import Resolver

struct CustomTabBarContainerView<Content:View>: View {
    
    //MARK: - Properties
    @StateObject var vm: CustomTabBarViewModel = Resolver.resolve()
    let content: Content
    
    //MARK: - Init
    
    init(@ViewBuilder content: () -> Content ) {
        self.content = content()
    }
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                content
                    .ignoresSafeArea(edges: .bottom)
    
                if !vm.isHidden {
                    CustomTabBarView()
                        .padding(.bottom)
                }

            }
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            vm.tabs = value
        }
    }
}


struct CustomTabBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarContainerView() {
            Color.red
        }
    }
}
