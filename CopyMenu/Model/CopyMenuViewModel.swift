//
//  CopyMenuViewModel.swift
//  CopyMenu
//
//  Created by Jose Espejo on 07/10/2024.
//

import Foundation


class CopyMenuViewModel: ObservableObject {
    @Published var menuItems: [MenuItem] = []
    
    // Key for UserDefaults
    private let menuListKey = "menuList"
    
    init() {
        loadMenuItems()
    }
    
    // Function to load menu items from UserDefaults or create initial data
    func loadMenuItems() {
        if let data = UserDefaults.standard.data(forKey: menuListKey),
           let savedMenuItems = try? JSONDecoder().decode([MenuItem].self, from: data) {
            menuItems = savedMenuItems
        } else {
            // Initial data if no menu items are found
            menuItems = [
                MenuItem(title: "Pizza"),
                MenuItem(title: "Burger"),
                MenuItem(title: "Pasta")
            ]
            saveMenuItems() // Save the initial data
        }
    }
    
    // Function to add a new menu item
    func addItem() {
        menuItems.append(MenuItem(title: "New item"))
        saveMenuItems()
    }
    
    // Function to delete a specific menu item by ID
    func deleteItem(_ menuItem: MenuItem) {
        menuItems.removeAll { $0.id == menuItem.id }
        saveMenuItems()
    }
    
    // Function to delete a menu item
    func deleteItems(at offsets: IndexSet) {
        menuItems.remove(atOffsets: offsets)
        saveMenuItems()
    }
    
    // Function to reorder menu items
    func moveItems(from source: IndexSet, to destination: Int) {
        menuItems.move(fromOffsets: source, toOffset: destination)
        saveMenuItems()
    }
    
    // Function to save menu items to UserDefaults
    func saveMenuItems() {
        if let data = try? JSONEncoder().encode(menuItems) {
            UserDefaults.standard.set(data, forKey: menuListKey)
        }
    }
}

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
