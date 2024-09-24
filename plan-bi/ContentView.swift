//
//  ContentView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 05.08.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StartView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
            }
            
            CheckInFlowView()
                .tabItem {
                    Label("Check In", systemImage: "apple.meditate")
                }
            
            ActivitiesView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
        }
        .tint(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
