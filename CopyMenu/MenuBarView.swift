//
//  MenuBarView.swift
//  CopyMenu
//
//  Created by Jose Espejo on 07/10/2024.
//

import SwiftUI

struct MenuBarView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        ForEach(viewModel.menuItems, id: \.self) { item in
            Button(item.title) {
                print("Selected: \(item.title)")
                
                // Set string to clipboard
                let pasteboard = NSPasteboard.general
                pasteboard.declareTypes([.string], owner: nil)
                NSPasteboard.general.setString(item.title, forType: .string)
            }
        }
        
        Divider()
        
        Button("Edit") {
            openWindow(id: EDIT_WINDOW_ID)
        }
        
        Divider()
        
        Button("Quit") {
            NSApplication.shared.terminate(nil)
        }
    }
}

#Preview {
    MenuBarView(viewModel: ViewModel() )
}
