import SceneKit
import ARKit

class BoundingBox: SCNNode {
    var extent: SIMD3<Float> = SIMD3<Float>(0.3, 0.3, 0.3)
    
    override init() {
        super.init()
        
        let boxGeometry = SCNBox(width: CGFloat(extent.x),
                                height: CGFloat(extent.y),
                                length: CGFloat(extent.z),
                                chamferRadius: 0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.yellow.withAlphaComponent(0.3)
        material.isDoubleSided = true
        boxGeometry.materials = [material]
        
        self.geometry = boxGeometry
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
} 