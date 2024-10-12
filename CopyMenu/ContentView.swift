//
//  ContentView.swift
//  CopyMenu
//
//  Created by Jose Espejo on 07/10/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: CopyMenuViewModel
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        //        GeometryReader { geometry in
        VStack {
            Text("Items").bold()
            
            List {
                ForEach(viewModel.menuItems) { menuItem in
                    Form {
                        HStack {
                            TextField("", text: Binding(
                                get: { menuItem.title },
                                set: { newTitle in
                                    if let index = viewModel.menuItems.firstIndex(where: { $0.id == menuItem.id }) {
                                        viewModel.menuItems[index].title = newTitle
                                        viewModel.saveMenuItems() // Save on edit
                                    }
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
                            .buttonStyle(BorderlessButtonStyle()) // Prevent interference with List row tap gesture
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                //                .onDelete(perform: viewModel.deleteItems)
                .onMove(perform: viewModel.moveItems)
            }
            //                .formStyle(.automatic)
            //            .formStyle(.columns)
            //            .frame(maxWidth: 400, minHeight: 0)
            //            .padding()
            //            .background(.red)
            //            .foregroundColor(.red)
//                        .fixedSize()
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            
            //            .padding(EdgeInsets(top: -10, leading: -20, bottom: -10, trailing: -20))
            //            .clipShape(Rectangle())
            //            .frame(maxHeight: min(CGFloat(viewModel.menuItems.count) * 50, 400)) // Max height constraint
            //            .frame(width: 300) // Fixed width for the window
            //            .listStyle(PlainListStyle())
            //            .padding()
            //            .background(Color.white)
            //            .cornerRadius(10)
            //            .shadow(radius: 10)
            //            .scrollDisabled(true)
            
            
            // Button to add a new menu item
            Button(action: {
                viewModel.addItem()
            }) {
                Image(systemName: "plus")
            }
            
            Button("Close") {
                dismissWindow(id: EDIT_WINDOW_ID)
            }
        }
        .padding(50)
        //            .frame(height: geometry.size.height)
        
    }
    //    }
}

#Preview {
    ContentView(viewModel: CopyMenuViewModel())
}
