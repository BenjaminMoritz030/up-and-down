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
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: changeColors ? [Color.green, Color.orange] : [Color.orange, Color.green]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.top)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                        changeColors.toggle()
                    }
                }

                VStack {
                    Text("Here are some activities you might like. Let's try to find some common ground.")
                        .font(.custom("Supreme Variable", size: 30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()

                    List {
                        ForEach(activities, id: \.self) { activity in
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
                .padding()
            }
        }
    }
}

#Preview {
    ActivityListView(activities: [])
}


