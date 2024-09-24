//
//  CalenderView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 23.09.24.
//

import SwiftUI
import MijickCalendarView

struct CalenderView: View {
    
    @State private var selectedDate: Date? = nil
    @State private var selectedRange: MDateRange? = .init()
    
    var body: some View {
        MCalendarView(selectedDate: $selectedDate, selectedRange: $selectedRange)
    }
}


#Preview {
    CalenderView()
}
