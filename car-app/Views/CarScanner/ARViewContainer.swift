import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    let viewModel: ScanningViewModel
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        arView.delegate = viewModel
        arView.session.delegate = viewModel
        viewModel.arView = arView
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
} 