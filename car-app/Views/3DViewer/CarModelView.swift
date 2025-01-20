import SwiftUI
import SceneKit

struct CarModelView: View {
    let car: CarModel
    
    var body: some View {
        SceneView(scene: createScene(), options: [.allowsCameraControl, .autoenablesDefaultLighting])
            .ignoresSafeArea()
            .navigationTitle(car.name)
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private func createScene() -> SCNScene {
        let scene = SCNScene()
        
        // Create a cube as placeholder with adjusted size
        let boxGeometry = SCNBox(width: 2, height: 1, length: 3, chamferRadius: 0.2)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.blue
        material.lightingModel = .physicallyBased
        boxGeometry.materials = [material]
        
        let boxNode = SCNNode(geometry: boxGeometry)
        boxNode.position = SCNVector3(0, 0.5, 0)
        
        // Add ambient light
        let ambientLight = SCNNode()
        ambientLight.light = SCNLight()
        ambientLight.light?.type = .ambient
        ambientLight.light?.intensity = 100
        scene.rootNode.addChildNode(ambientLight)
        
        // Add directional light
        let directionalLight = SCNNode()
        directionalLight.light = SCNLight()
        directionalLight.light?.type = .directional
        directionalLight.light?.intensity = 800
        directionalLight.position = SCNVector3(5, 5, 5)
        directionalLight.eulerAngles = SCNVector3(-Float.pi/4, Float.pi/4, 0)
        scene.rootNode.addChildNode(directionalLight)
        
        // Add the car model (cube placeholder)
        scene.rootNode.addChildNode(boxNode)
        
        // Setup camera with adjusted position
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(5, 3, 8) // Adjusted for better initial view
        cameraNode.camera?.zNear = 0.1
        cameraNode.camera?.zFar = 100
        scene.rootNode.addChildNode(cameraNode)
        
        // Set the default view point
        let constraint = SCNLookAtConstraint(target: boxNode)
        constraint.isGimbalLockEnabled = true
        cameraNode.constraints = [constraint]
        
        // Add orbit controls
        let orbitNode = SCNNode()
        orbitNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(orbitNode)
        
        // Set scene background
        scene.background.contents = UIColor.systemBackground
        
        // Add floor for reference
        let floorGeometry = SCNFloor()
        let floorMaterial = SCNMaterial()
        floorMaterial.diffuse.contents = UIColor.gray.withAlphaComponent(0.2)
        floorGeometry.materials = [floorMaterial]
        let floorNode = SCNNode(geometry: floorGeometry)
        scene.rootNode.addChildNode(floorNode)
        
        return scene
    }
}

// SceneView coordinator to handle zoom and camera limits
class SceneViewCoordinator: NSObject, SCNSceneRendererDelegate {
    static let minZoom: Float = 4.0
    static let maxZoom: Float = 15.0
    static let minY: Float = 0.5  // Minimum height above the floor
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let camera = renderer.pointOfView else { return }
        
        // Handle zoom limits
        let distance = sqrt(
            camera.position.x * camera.position.x +
            camera.position.y * camera.position.y +
            camera.position.z * camera.position.z
        )
        
        if distance < SceneViewCoordinator.minZoom {
            let scale = SceneViewCoordinator.minZoom / distance
            camera.position = SCNVector3(
                camera.position.x * scale,
                max(camera.position.y * scale, SceneViewCoordinator.minY),
                camera.position.z * scale
            )
        } else if distance > SceneViewCoordinator.maxZoom {
            let scale = SceneViewCoordinator.maxZoom / distance
            camera.position = SCNVector3(
                camera.position.x * scale,
                max(camera.position.y * scale, SceneViewCoordinator.minY),
                camera.position.z * scale
            )
        }
        
        // Prevent camera from going below floor
        if camera.position.y < SceneViewCoordinator.minY {
            camera.position.y = SceneViewCoordinator.minY
        }
    }
}

extension CarModelView {
    private var sceneView: SCNView {
        let view = SCNView()
        view.scene = createScene()
        view.allowsCameraControl = true
        view.defaultCameraController.maximumVerticalAngle = 80  // Reduced from 85
        view.defaultCameraController.minimumVerticalAngle = -45 // Changed from -85 to prevent looking up from below
        view.defaultCameraController.inertiaEnabled = true
        view.defaultCameraController.interactionMode = .orbitTurntable
        view.delegate = SceneViewCoordinator()
        return view
    }
} 