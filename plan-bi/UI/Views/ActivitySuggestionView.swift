////
////  ActivitySuggestionView.swift
////  plan-bi
////
////  Created by Benjamin Moritz on 11.09.24.
////
//
//import SwiftUI
//
//
//struct ActivitySuggestionView: View {
//    var mood: String
//    var drive: String
//    
//    @State private var showingActivitySheet = false
//    @StateObject var viewModel = ActivityViewModel()
//    
//    var body: some View {
//        
//        VStack {
//            Text("Basierend auf deiner Stimmung und deinem Antrieb:")
//                .font(.headline)
//                .padding()
//            
//            List(activities, id: \.self) { activity in
//                Button(action: {
//                    viewModel.loadActivities()
//                    
//                }) {
//                    Text(activity.title ?? "")
//                }
//                }
//                .padding()
//            }
//            HStack {
//                Button(action: {
//                    showingActivitySheet = true
//                }) {
//                    Text("Eigene Aktivität")
//                    //                        .foregroundColor(.white)
//                    //                        .padding()
//                    //                        .background(Color.blue)
//                    //                        .cornerRadius(8)
//                }
//                
//                
//                Button(action: {
//                }) {
//                    Text("Abbrechen")
//                        .foregroundColor(.red)
//                        .padding()
//                }
//            }
//            .padding()
//            
//        }
//        .navigationTitle("Aktivitäten")
//        
//        .sheet(isPresented: $showingActivitySheet) {
//            ActivitySheetView(mood: mood, drive: drive)
//        }
//    }
//    
//}
//    
//    
//    struct ActivitySuggestionView_Previews: PreviewProvider {
//        static var previews: some View {
//            ActivitySuggestionView(mood: "Neutral", drive: "Mittel")
//        }
//    }
