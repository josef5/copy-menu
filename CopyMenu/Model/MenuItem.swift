//
//  MenuItem.swift
//  CopyMenu
//
//  Created by Jose Espejo on 14/10/2024.
//

import Foundation

// Model for a single MenuItem that conforms to Codable for persistence
struct MenuItem: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    
    // Initializer to create new menu items without specifying the id manually
    init(id: UUID = UUID(), title: String) {
        self.id = id
        self.title = title
    }
}
