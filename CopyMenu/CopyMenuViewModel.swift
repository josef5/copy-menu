//
//  CopyMenuViewModel.swift
//  CopyMenu
//
//  Created by Jose Espejo on 07/10/2024.
//

import Foundation

class CopyMenuViewModel: ObservableObject {
    @Published var menuItems: [String] = ["Item 1", "Item 2", "Item 3"]
}
