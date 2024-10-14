//
//  CopyMenuViewModel.swift
//  CopyMenu
//
//  Created by Jose Espejo on 07/10/2024.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var menuItems: [MenuItem] = []

    // Key for UserDefaults
    private let menuListKey = "copyMenuList"

    init() {
        loadMenuItems()
    }

    // Function to load menu items from UserDefaults or create initial data
    func loadMenuItems() {
        if let data = UserDefaults.standard.data(forKey: menuListKey),
           let savedMenuItems = try? JSONDecoder().decode([MenuItem].self, from: data) {
            menuItems = savedMenuItems
        } else {
            
            // Initial data
            menuItems = [
                MenuItem(title: "Item 1"),
                MenuItem(title: "Item 2")
            ]
            
            saveMenuItems() // Save the initial data
        }
    }

    // Function to add a new menu item
    func addItem() {
        menuItems.append(MenuItem(title: "New item"))
        saveMenuItems()
    }
    
    func updateItem(_ menuItem: MenuItem, newTitle: String) {
        if let index = menuItems.firstIndex(where: { $0.id == menuItem.id }) {
            menuItems[index].title = newTitle
            saveMenuItems()
        }
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
