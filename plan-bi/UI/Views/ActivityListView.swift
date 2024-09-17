//
//  ActivityListView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 14.09.24.
//

import SwiftUI

struct ActivityListView: View {
    @StateObject var viewModel = ActivityViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.activities, id: \.self) { acitvity in
                    Text(acitvity.name ?? "")
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let activity = viewModel.activities[index]
                        viewModel.deleteActivity(activity: activity)
                    }
                }
            }
            .navigationBarTitle("Aktivitäten")
            .navigationBarItems(trailing: Button(action: {
                viewModel.addActivity(name: "Ruhepause")
            }, label: {
                Text("Aktivität hinzufügen")
            }))
        }
        .onAppear {
            viewModel.fetchActivity()
        }
    }
}

#Preview {
    ActivityListView()
}
