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
                    Label("Startseite", systemImage: "house.fill")
            }
            ActivitiesView()
                .tabItem {
                    Label("Startseite", systemImage: "calendar")
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
