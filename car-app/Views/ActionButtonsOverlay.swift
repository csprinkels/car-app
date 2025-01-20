import SwiftUI

struct ActionButtonsOverlay: View {
    @Binding var showingAddCarOptions: Bool
    @Binding var showingActionButtons: Bool
    @Binding var showingScanView: Bool
    @Binding var showingModelPicker: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        showingAddCarOptions = false
                        showingActionButtons = false
                    }
                }
            
            VStack(spacing: 15) {
                ActionButton(
                    title: "Scan Car with LiDAR",
                    systemImage: "camera.fill.badge.ellipsis"
                ) {
                    showingScanView = true
                    showingAddCarOptions = false
                    showingActionButtons = false
                }
                
                ActionButton(
                    title: "Import 3D Model",
                    systemImage: "square.and.arrow.down.fill"
                ) {
                    showingModelPicker = true
                    showingAddCarOptions = false
                    showingActionButtons = false
                }
            }
            .padding(.horizontal, 30)
            .scaleEffect(showingActionButtons ? 1 : 0.8)
            .offset(y: showingActionButtons ? 0 : 20)
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: showingActionButtons)
        }
    }
} 