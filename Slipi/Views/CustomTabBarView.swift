//
//  CustomTabBarView.swift
//  Slipi
//

import SwiftUI

struct CustomTabBarView: View {
    @Environment(NavigationRouter.self) private var router
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(AppTab.allCases) { tab in
                tabItem(for: tab)
                Spacer()
            }
        }
        .padding(.vertical, 12)
        .background(
            Color.brandBackground
                .ignoresSafeArea(edges: .bottom)
                .overlay(
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(.white.opacity(0.1)),
                    alignment: .top
                )
        )
    }
    
    private func tabItem(for tab: AppTab) -> some View {
        let isSelected = router.selectedTab == tab
        
        return Button {
            if isSelected {
                router.popToRoot()
            } else {
                router.selectedTab = tab
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: isSelected ? tab.icon : tab.icon.replacingOccurrences(of: ".fill", with: ""))
                    .font(.system(size: 22))
                
                Text(tab.title)
                    .font(.system(size: 11))
            }
            .foregroundColor(isSelected ? .brandOrange : .white.opacity(0.5))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CustomTabBarView()
        .environment(NavigationRouter())
}
