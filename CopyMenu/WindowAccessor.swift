//
//  WindowAccessor.swift
//  Floating Window
//
//  Created by Jose Espejo on 15/10/2024.
//
// https://stackoverflow.com/a/77184303/896907

import SwiftUI
import AppKit

struct WindowAccessor: NSViewRepresentable {
    @Binding var window: NSWindow?

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            self.window = view.window
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}
