//
//  ContentView.swift
//  car-app
//
//  Created by Christian Sprinkel on 1/19/25.
//

import SwiftUI
import RealityKit
import ARKit
import SceneKit

struct ContentView: View {
    @State private var showingAddCarOptions = false
    @State private var showingScanView = false
    @State private var showingModelPicker = false
    @State private var showingActionButtons = false
    @State private var selectedCar: CarModel? = nil
    @State private var userName = "sprinkels"
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Garage Tab
            NavigationStack {
                ZStack {
                    // Background
                    Color(.systemBackground)
                        .ignoresSafeArea()
                    
                    if let car = selectedCar {
                        CarModelView(car: car)
                    } else {
                        EmptyStateView(
                            showingAddCarOptions: $showingAddCarOptions,
                            showingActionButtons: $showingActionButtons
                        )
                    }
                    
                    if showingAddCarOptions {
                        ActionButtonsOverlay(
                            showingAddCarOptions: $showingAddCarOptions,
                            showingActionButtons: $showingActionButtons,
                            showingScanView: $showingScanView,
                            showingModelPicker: $showingModelPicker
                        )
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(userName)
                            .font(.headline)
                    }
                }
                .sheet(isPresented: $showingScanView) {
                    ScanView()
                }
                .sheet(isPresented: $showingModelPicker) {
                    ModelPickerView(selectedCar: $selectedCar)
                }
            }
            .tabItem {
                Image(systemName: "car.2")
                Text("Garage")
            }
            .tag(0)
            
            // Discover Tab
            NavigationStack {
                Text("Discover View")
                    .navigationTitle("Discover")
            }
            .tabItem {
                Image(systemName: "safari")
                Text("Discover")
            }
            .tag(1)
            
            // Map Tab
            NavigationStack {
                Text("Map View")
                    .navigationTitle("Map")
            }
            .tabItem {
                Image(systemName: "map")
                Text("Map")
            }
            .tag(2)
            
            // Profile Tab
            NavigationStack {
                Text("Profile View")
                    .navigationTitle("Me")
            }
            .tabItem {
                Image(systemName: "person")
                Text("Me")
            }
            .tag(3)
        }
    }
}

#Preview {
    ContentView()
}
