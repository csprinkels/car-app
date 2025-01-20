import SwiftUI
import ARKit
import RealityKit

struct ScanView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var scanningViewModel = ScanningViewModel()
    
    var body: some View {
        ZStack {
            ARViewContainer(viewModel: scanningViewModel)
                .ignoresSafeArea()
            
            ScanningOverlay(
                isScanning: scanningViewModel.isScanning,
                statusMessage: scanningViewModel.statusMessage,
                onCancel: { dismiss() },
                onToggleScan: { scanningViewModel.toggleScanning() }
            )
        }
        .alert("Scanning Error", isPresented: $scanningViewModel.showAlert) {
            Button("OK") { }
        } message: {
            Text(scanningViewModel.alertMessage)
        }
    }
}

struct ScanningOverlay: View {
    let isScanning: Bool
    let statusMessage: String
    let onCancel: () -> Void
    let onToggleScan: () -> Void
    
    var body: some View {
        VStack {
            // Top toolbar
            HStack {
                Button("Cancel", action: onCancel)
                    .padding()
                
                Spacer()
                
                Text(statusMessage)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(.black.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Spacer()
                
                Button(isScanning ? "Stop" : "Start", action: onToggleScan)
                    .padding()
            }
            .background(.ultraThinMaterial)
            
            Spacer()
            
            // Bottom instructions
            if !isScanning {
                VStack(spacing: 20) {
                    Text("Position your car in a well-lit area")
                        .font(.headline)
                    Text("Move around the car slowly to capture all angles")
                        .font(.subheadline)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
            }
        }
    }
} 