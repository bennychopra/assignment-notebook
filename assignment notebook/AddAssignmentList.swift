//
//  AddAssignmentList.swift
//  assignment notebook
//
//  Created by Benny Chopra on 2/19/25.
//

import SwiftUI
struct AddAssignmentView: View {
    @Environment(\.presentationMode) var presentationMode
    static let courses = ["Physics", "Sophmore collage prep", "Geomatry", "Health", "Resource", "U.S. History", "Mobile App Devolpment"]
    @ObservedObject var assignmentList: AssignmentList
    @State private var course = ""
    @State private var description = ""
    @State private var dueDate = Date()
    var body: some View {
        NavigationView {
            Form {
                Picker("Course", selection: $course) {
                    ForEach(Self.courses, id: \.self) { course in
                        Text(course)
                    }
                }
                TextField("Description", text: $description)
                DatePicker ("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("Add New Assignment Item", displayMode: .inline)
            .navigationBarItems (trailing: Button ("Save") {
                if course.count > 0 && description.count > 0 {
                    let item = AssignmentItem(id: UUID(), course: course,
                                        description: description, dueDate: dueDate)
                    assignmentList.items.append(item)
                    presentationMode.wrappedValue.dismiss ()
                }
            })
        }
    }
}
#Preview {
    AddAssignmentView(assignmentList: AssignmentList())
}

