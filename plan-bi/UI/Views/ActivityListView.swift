//
//  ActivityListView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 14.09.24.
//

import SwiftUI

struct ActivityListView: View {
    @State private var changeColors = false
    var activities: [ActivityEntity]
    var filteredMood: String
    var filteredDrive: String

    var filteredActivities: [ActivityEntity] {
        return activities.filter { activity in
            (activity.mood == filteredMood) && (activity.drive == filteredDrive)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                MeshGradient(
                    width: 3,
                    height: 3,
                    points: [
                        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                        [0.0, 0.2], [0.0, 0.0], [1.0, 0.0], [1.0, 0.5],
                        [0.0, 1.0], [1.0, 1.0], [1.0, 1.0]
                    ],
                    colors: [
                        .purple, .green, .purple,
                        .purple, .orange, .green,
                        .green, .yellow, .purple
                    ]
                )
                .edgesIgnoringSafeArea(.top)

                VStack {
                    Text("Here are some activities you might like. Let's try to find some common ground.")
                        .font(.custom("Supreme Variable", size: 30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()

                    if filteredActivities.isEmpty {
                        Text("Sorry, no activities match your mood and drive combination.")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        List {
                            ForEach(filteredActivities, id: \.self) { activity in
                                NavigationLink(destination: ActivityDetailView(activity: activity)) {
                                    Text(activity.title ?? "Sorry, no title available.")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.purple)
                                        .cornerRadius(10)
                                }
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                            }
                            .padding(.horizontal, 10)
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ActivityListView(activities: [], filteredMood: "Good", filteredDrive: "High")
}
