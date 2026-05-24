//
//  CustomTabBarView.swift
//  Slipi
//

import SwiftUI

struct CustomTabBarView: View {
    @Environment(NavigationRouter.self) private var router
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases) { tab in
                tabItem(for: tab)
            }
        }
        .padding(.top, 12)
        .padding(.bottom, 24) // Extra padding for home indicator
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
                .overlay(alignment: .top) {
                    Divider()
                }
        }
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
                    .font(.system(size: 20, weight: .semibold))
                
                Text(tab.title)
                    .font(.system(size: 10, weight: .medium))
            }
            .foregroundColor(isSelected ? .accentColor : .secondary)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CustomTabBarView()
        .environment(NavigationRouter())
}
