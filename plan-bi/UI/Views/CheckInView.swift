//
//  CheckInView.swift
//  plan-bi
//
//  Created by Benjamin Moritz on 11.09.24.
//

import SwiftUI

struct CheckInView: View {
    
    @StateObject var viewModel = ActivityViewModel()
    
    @State private var isAnimating = false
    
    @State private var mood: String = "Medium"
    @State private var drive: String = "Medium"
    
    @State private var showMoodPicker = false
    @State private var showDrivePicker = false
    
    let moods = ["Very Bad", "Bad", "Medium", "Good", "Very Good"]
    let drives = ["Very Low", "Low", "Medium", "High", "Very High"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                MeshGradient(
                    width: 3,
                    height: 3,
                    points: [
                        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                        [0.0, 0.2], [0.0, 0.0], [1.0, 0.0],
                        [0.0, 1.0], [1.0, 1.0], [1.0, 1.0]
                    ],
                    colors: [
                        .purple, .yellow, .purple,
                        .purple, .purple, .cyan,
                        .cyan, .yellow, .yellow
                    ]
                )
                .edgesIgnoringSafeArea(.top)
                
//                Color.clear
//                    .background(.ultraThinMaterial)
//                    .edgesIgnoringSafeArea(.top)
                
                VStack {
                    Image("pb-logo-neu-fff")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: false)) {
                                isAnimating = true
                            }
                        }
                    
                    Spacer()
                    
                    Text("Tell me, how do you feel today?")
                        .font(.custom("Supreme Variable", size: 30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Section(header: Text("Select your mood"))
                        {
                            Button(action: {
                                showMoodPicker.toggle()
                            }) {
                                HStack {
                                    Text("Mood:")
                                    Spacer()
                                    Text(mood)
                                        .foregroundColor(.white)
                                }
                                .font(.system(size: 20))
                            }
                            .sheet(isPresented: $showMoodPicker) {
                                VStack {
                                    Text("Your mood is like the weather. Always changing, and that’s okay. Embrace each moment as it comes, knowing you are perfectly fine just as you are.")
                                        .font(.custom("Supreme Variable", size: 30))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.purple)
                                        .padding()
                                    
                                    Divider()
                                        .frame(height: 2)
                                        .background(Color.purple)
                                        .padding(.horizontal, 20)
                                    
                                    Picker("Mood", selection: $mood) {
                                        ForEach(moods, id: \.self) {
                                            Text($0)
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(.purple)
                                        }
                                    }
                                    .labelsHidden()
                                    .pickerStyle(WheelPickerStyle())
                                    Button("Done") {
                                        showMoodPicker = false
                                    }
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.purple)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 20)
                                }
                            }
                        }
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        
                        Section(header: Text("Select your drive")) {
                            Button(action: {
                                showDrivePicker.toggle()
                            }) {
                                HStack {
                                    Text("Drive:")
                                    Spacer()
                                    Text(drive)
                                        .foregroundColor(.white)
                                }
                                .font(.system(size: 20))
                            }
                            .sheet(isPresented: $showDrivePicker) {
                                ZStack {
                                    Color.white
                                        .ignoresSafeArea()
                                    VStack {
                                        Text("Move gently through today. Be kind to yourself, and trust the process.")
                                            .font(.custom("Supreme Variable", size: 30))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.purple)
                                            .padding()
                                        
                                        Divider()
                                            .frame(height: 2)
                                            .background(Color.purple)
                                            .padding(.horizontal, 20)
                                        
                                        Picker("Drive", selection: $drive) {
                                            ForEach(drives, id: \.self) {
                                                Text($0)
                                                    .font(.system(size: 20, weight: .bold))
                                                    .foregroundColor(.purple)
                                            }
                                        }
                                        .labelsHidden()
                                        .pickerStyle(WheelPickerStyle())
                                        Button("Done") {
                                            showDrivePicker = false
                                        }
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.purple)
                                        .cornerRadius(10)
                                        .padding(.horizontal, 20)
                                    }
                                }
                            }
                        }
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    }
                    
                    
                    NavigationLink(destination: ActivityListView(activities: viewModel.suggestActivities(for: mood, and: drive), filteredMood: mood, filteredDrive: drive)) {
                        Text("Suggest Activities")
                            .font(.system(size: 20, weight: .bold))
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.top, 50)
                }
                .padding()
            }
        }
    }
}
    
    #Preview {
        CheckInView()
    }
