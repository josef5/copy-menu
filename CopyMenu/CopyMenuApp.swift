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
    @StateObject private var viewModel = ViewModel()
    @State var window: NSWindow?
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some Scene {
        MenuBarExtra("Menu", systemImage: "clipboard") {
            MenuBarView(viewModel: viewModel)
        }
        .menuBarExtraStyle(.menu)

        Window("Edit Menu", id: EDIT_WINDOW_ID) {
            EditView(viewModel: viewModel)
                .frame(minWidth: 350, minHeight: max(CGFloat(viewModel.menuItems.count) * 50, 300))
                .background(WindowAccessor(window: $window))
                .onChange(of: window) { _, newWindow in
                    newWindow?.level = .floating
                }
        }
        .windowResizability(.contentSize)
        .defaultPosition(.center)
//        .windowLevel(.floating) // TODO: implement in macOS 15
    }
}
