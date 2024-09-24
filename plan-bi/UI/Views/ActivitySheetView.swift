//
//  ActivitySheetView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 18.09.24.
//

import SwiftUI

struct ActivitySheetView: View {
    
    @StateObject var viewModel = ActivityViewModel()
    
    var mood: String
    var drive: String
    
    @State private var activityTitle = ""
    @State private var activityMood = ""
    @State private var activityDrive = ""
    @State private var notificated = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Name of Your Activity")) {
                        TextField("Description", text: $activityTitle)
                    }
                    Section(header: Text("Details of Your Activity")) {
                        TextField("Description", text: $activityTitle)
                    }
                }
                .navigationTitle("Add Your own Activity")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            
                            print("Save successfully")
                        }) {
                            Text("Save")
//                                .foregroundColor(.white)
//                                .padding()
//                                .background(Color.blue)
//                                .cornerRadius(8)
                        }
                        Button(action: {
                            
                        }) {
                            Text("Cancel")
                                .foregroundColor(.red)
//                                .padding()
//                                .background(Color.blue)
//                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ActivitySheetView(mood: "Sehr schlecht", drive: "Sehr hoch")
}
