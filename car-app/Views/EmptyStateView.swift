import SwiftUI

struct EmptyStateView: View {
    @Binding var showingAddCarOptions: Bool
    @Binding var showingActionButtons: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("No Car Selected")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("Import or scan a car to get started")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top, 4)
            
            Button(action: {
                showingAddCarOptions = true
                showingActionButtons = true
            }) {
                Text("Add Car")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }
} 