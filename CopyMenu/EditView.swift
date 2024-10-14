//
//  ContentView.swift
//  CopyMenu
//
//  Created by Jose Espejo on 07/10/2024.
//

import SwiftUI

struct EditView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        VStack {
            Text("Items").bold()
            
            List {
                ForEach(viewModel.menuItems) { menuItem in
                    Form {
                        HStack {
                            TextField("", text: Binding(
                                get: { menuItem.title },
                                set: { newTitle in
                                    viewModel.updateItem(menuItem, newTitle: newTitle)
                                }
                            ))
                            
                            Spacer()
                            
                            // Drag handle icon to indicate reordering capability
                            Image(systemName: "line.horizontal.3")
                                .foregroundColor(.gray)
                                .onHover { hovering in
                                    if hovering {
                                        NSCursor.openHand.push()
                                    } else {
                                        NSCursor.pop() // Restore default cursor
                                    }
                                }
                            
                            Spacer().frame(width: 12)
                            
                            // Delete button
                            Button(action: {
                                viewModel.deleteItem(menuItem)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .onMove(perform: viewModel.moveItems)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .frame(height: CGFloat(viewModel.menuItems.count) * 30)
            .scrollDisabled(true)
            
            Spacer().frame(height: 20)
            
            HStack {
                Button("Add Item") {
                    viewModel.addItem()
                }
                
                Spacer().frame(width: 20)
                
                Button("Close") {
                    dismissWindow(id: EDIT_WINDOW_ID)
                }
            }
        }
        .padding(50)
        .frame(minWidth:480)
        .fixedSize()
        
    }
}

#Preview {
    EditView(viewModel: ViewModel())
}
