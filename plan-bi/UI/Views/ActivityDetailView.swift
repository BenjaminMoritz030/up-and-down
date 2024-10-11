//
//  ActivityDetailView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 23.09.24.
//

import SwiftUI
import MetalKit

struct ActivityDetailView: View {
    
    @StateObject var viewModel = ActivityViewModel()
    
    var activity: ActivityEntity
    
    @State private var changeColors = false
    @State private var showDatePicker = false
    @State private var selectedDate: Date = Date()
    @State private var showAlert = false
    @State private var alertMessage = ""
    // var for metal shader
    @State private var elapsed: Float = 0.0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: changeColors ? [Color.green, Color.orange] : [Color.orange, Color.green]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea(edges: .top)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                    changeColors.toggle()
                }
            }
            
            VStack {
                Text(activity.title ?? "No Title")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .padding()
                
                Text(activity.details ?? "No Details")
                    .font(.body)
                    .foregroundColor(.black)
                    .padding()
                
                Image("pb-logo-neu-fff")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding()
                    .distortionEffect(
                        ShaderLibrary.wave(.float(elapsed)),
                        maxSampleOffset: CGSize(width: 31, height: 31)
                    )
                
                Spacer()
                
                Button(action: {
                    showDatePicker.toggle()
                }) {
                    HStack {
                        Text("Set Date")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Text("\(selectedDate, formatter: dateFormatter)")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(10)
                }
                .sheet(isPresented: $showDatePicker) {
                    VStack {
                        DatePicker(
                            "Select Date",
                            selection: $selectedDate,
                            in: Date()...,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        
                        Button("Save Date") {
                            if Calendar.current.isDateInToday(selectedDate) {
                                alertMessage = "Your activity has been saved. Go to your calendar to see it."
                            } else {
                                alertMessage = "Your activity has been saved. Go to your calendar to see it."
                            }
                            viewModel.savePlannedActivity(date: selectedDate, activity: activity)
                            showDatePicker = false
                            showAlert = true
                        }
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Activity Saved"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}

#Preview {
    ActivityDetailView(activity: ActivityEntity(context: PersistentStore.shared.context))
}

