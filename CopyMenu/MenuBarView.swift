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
            Button(item.title) {
                print("Selected: \(item.title)")
            }
        }
        
        Divider()
        
        Button("Edit") {
            openWindow(id: EDIT_WINDOW_ID)
        }
        
        Divider()
        
        Button("Quit") {
            
        }
    }
}

#Preview {
    MenuBarView(viewModel: CopyMenuViewModel() )
}
