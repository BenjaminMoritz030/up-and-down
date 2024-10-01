//
//  ContentView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 05.08.24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var activityViewModel = ActivityViewModel()
    @State private var selectedDate: Date = Date()
    
    
    var body: some View {
        TabView {
            StartView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            CheckInView()
                .tabItem {
                    Label("Check In", systemImage: "apple.meditate")
                }
            
            CalenderView(viewModel: activityViewModel, selectedDate: $selectedDate)
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
