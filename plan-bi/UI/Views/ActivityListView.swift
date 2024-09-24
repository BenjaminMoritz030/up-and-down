//
//  ActivityListView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 14.09.24.
//

import SwiftUI

struct ActivityListView: View {
    var activities: [ActivityEntity]
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities, id: \.self) { activity in
                    NavigationLink(destination: ActivityDetailView(activity: activity)) {
                        Text(activity.title ?? "")
                    }
                }
                .navigationBarTitle("Suggested Activities")
            }
        }
    }
}

#Preview {
    ActivityListView(activities: [])
}
