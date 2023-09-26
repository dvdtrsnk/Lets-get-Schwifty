//
//  CustomTapBarView.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Třešňák on 21.09.2023.
//

import SwiftUI

struct TapBarView: View {
    
    let tabs: [TapBarItem]
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
            }
        }
        .frame(maxHeight: 70)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(40)

    }
}

struct CustomTapBarView_Previews: PreviewProvider {
    static var previews: some View {
        let tabs: [TapBarItem] = [
            TapBarItem(iconName: "house", color: ""),
            TapBarItem(iconName: "star", color: "")
        ]
        TapBarView(tabs: tabs)
    }
}

extension TapBarView {
    
    private func tabView(tab: TapBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.system(size: 25))
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(.red)
        .padding(.vertical, 8)
        .cornerRadius(10)
    }
}

struct TapBarItem: Hashable {
    let iconName: String
    let color: String
}
