//
//  ContentView.swift
//  assignment notebook
//
//  Created by Benny Chopra on 2/19/25.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var assignmentList = AssignmentList()
    @State private var showingAddAssignmentView = false
    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentList.items) { item in
                    HStack {
                        VStack {
                            VStack(alignment: .leading, content: {
                                Text(item.course).font(.headline)
                                Text(item.description)
                            })
                            .padding(10)
                            .background(Color.gray)
                        }
                        .padding(2)
                        .background(Color.black)
                            Spacer()
                            Text(item.dueDate,style: .date)
                            .foregroundColor(Color.gray)
                            .italic()
                    }
                }
                .onMove(perform: { indices, newOffset in
                    assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    assignmentList.items.remove(atOffsets: indexSet)
                })
            }
            .sheet(isPresented: $showingAddAssignmentView, content: {
                AddAssignmentView(assignmentList: assignmentList)
            })
            .navigationBarTitle("Assignment Notebook", displayMode: .inline)
            .navigationBarItems(leading: EditButton(),
            trailing: Button(action: {
                showingAddAssignmentView = true
            }, label: {
                Image(systemName: "plus")
            }))
        }
    }
}
#Preview {
    ContentView()
}
struct AssignmentItem: Identifiable, Codable{
    var id = UUID()
    var course = String()
    var description = String()
    var dueDate = Date()
}
