//
//  ContentView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 05.08.24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0
    
    @StateObject var activityViewModel = ActivityViewModel()
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        TabView {
            StartView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            CheckInView()
                .tabItem {
                    Label("Check In", systemImage: "door.left.hand.open")
                }
                .tag(1)
            
            CalenderView(viewModel: activityViewModel, selectedDate: $selectedDate)
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(2)
        }
        .accentColor(.black)
    }
}


#Preview {
        ContentView()
}
