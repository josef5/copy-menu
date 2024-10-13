//
//  CopyMenuApp.swift
//  CopyMenu
//
//  Created by Jose Espejo on 07/10/2024.
//

import SwiftUI

let EDIT_WINDOW_ID = "edit-window"

@main
struct CopyMenuApp: App {
    @StateObject private var viewModel = CopyMenuViewModel()
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some Scene {
        MenuBarExtra("Menu", systemImage: "clipboard") {
            MenuBarView(viewModel: viewModel)
        }
        .menuBarExtraStyle(.menu)
        
        Window("Edit Menu", id: EDIT_WINDOW_ID) {
            ContentView(viewModel: viewModel)
                .frame(minWidth: 350, minHeight: max(CGFloat(viewModel.menuItems.count) * 50, 300))
        }
        .windowResizability(.contentSize)
        .defaultPosition(.center)
//        .windowLevel(.floating)
    }
}
