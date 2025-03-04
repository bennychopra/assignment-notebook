//
//  AssignimentList.swift
//  assignment notebook
//
//  Created by Benny Chopra on 2/19/25.
//

import Foundation
class AssignmentList: ObservableObject {
    @Published var items : [AssignmentItem] {
        didSet {
            if let encodedData = try? JSONEncoder() .encode(items) {
                UserDefaults.standard.set(encodedData, forKey: "data")
            }
        }
    }
    init() {
        if let data = UserDefaults.standard.data(forKey: "data") {
            if let decodedData = try? JSONDecoder().decode([AssignmentItem].self, from: data) {
                items = decodedData
                return
            }
        }
        items = []
    }
}

