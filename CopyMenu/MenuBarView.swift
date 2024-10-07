//
//  MenuBarView.swift
//  CopyMenu
//
//  Created by Jose Espejo on 07/10/2024.
//

import SwiftUI

struct MenuBarView: View {
    @ObservedObject var viewModel: CopyMenuViewModel
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        ForEach(viewModel.menuItems, id: \.self) { item in
            Button(item) {
                print("Selected: \(item)")
            }
        }
        
        Divider()
        
        Button("Edit") {
            openWindow(id: "edit-menu")
        }
    }
}

#Preview {
    MenuBarView(viewModel: CopyMenuViewModel() )
}
