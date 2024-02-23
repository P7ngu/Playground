import ARKit
import RealityKit
import Combine
import SwiftUI

class MyARView: ARView{
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        addStaticImage()
    }
    
    dynamic required init?(coder decoder: NSCoder){
        fatalError("init with a coder has not been implemented yet")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        subscribeToActionStream()
        addStaticImage()
        addImageOnWall()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func subscribeToActionStream() {
        ARManager.shared
            .actionStream
            .sink { [weak self] action in
                switch action {
                case .placeBlock(let color):
                    self?.placeBlock(ofColor: color)
                    
                case .removeAllAnchors:
                    self?.scene.anchors.removeAll()
                }
                
            }
            .store(in: &cancellables)
    }
    
    func configurationSession(){
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .vertical
        session.run(configuration)
    }
    
    func anchorSetup() {
        //iPhone-centered
        let coordinateAnchor = AnchorEntity(world: .zero) 
        //Alternatives:
        let _ = AnchorEntity(plane: .horizontal)
        
        let _ = AnchorEntity(.face)
        
        //Let's add the selected anchor
        scene.addAnchor(coordinateAnchor)
        
    }
    
    func entitySetup() {
        //Here we can load entities from different places, usdz files, reality file, code, etc
        let box = MeshResource.generateBox(size: 1)
        let entity2 = ModelEntity(mesh: box)
        
        //unused example
        let entity  = try? Entity.load(named: "penguin-portrait")
        
        //We have to then add the entity to the scene
        let anchor = AnchorEntity()
        anchor.addChild(entity ?? entity2)
    }
    
    func placeBlock(ofColor color: Color) {
        let block = MeshResource.generateBox(size: 1)
        let material = SimpleMaterial(color: UIColor(color), isMetallic: false)
        let entity = ModelEntity(mesh: block, materials: [material])
        
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(entity)
        
        scene.addAnchor(anchor)
    }
    
    func addStaticImage() {
        // 1. Create a material with the image as a texture
        var material = UnlitMaterial()
        if let texture = try? TextureResource.load(named: "penguin") { 
            material.baseColor = MaterialColorParameter.texture(texture)
        }
        
        // 2. Create a plane mesh with the desired size
        let planeMesh = MeshResource.generatePlane(width: 0.2, depth: 0.35) // Adjust width and height as needed
        
        // 3. Create a model entity using the plane mesh and the material
        let imageEntity = ModelEntity(mesh: planeMesh, materials: [material])
        
        // 4. Position the entity in the world (or relative to an anchor)
        let anchorEntity = AnchorEntity(world: .zero)
        anchorEntity.addChild(imageEntity)
        
        // 5. Add the anchor entity to the scene
        self.scene.addAnchor(anchorEntity)
    }
    
    func addImageOnWall() {
        // 1. Create a material with the image as a texture
        var material = UnlitMaterial()
        if let texture = try? TextureResource.load(named: "melting") { // Replace "wallImage" with your image name
            material.baseColor = MaterialColorParameter.texture(texture)
        }
        // 2. Create a plane mesh with the desired size
        let planeMesh = MeshResource.generatePlane(width: 0.2, height: 0.35) // Adjust width and height as needed for the wall
        
        // 3. Create a model entity using the plane mesh and the material
        let imageEntity = ModelEntity(mesh: planeMesh, materials: [material])
        
        // 4. Position the entity in the world (or relative to an anchor) - make it vertical
        let anchorEntity = AnchorEntity(world: .zero)
        // Adjust the orientation to make the plane vertical
        imageEntity.orientation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0]) // Rotate 90 degrees around the X-axis to make it vertical
        anchorEntity.addChild(imageEntity)
        
        // 5. Position the imageEntity to simulate being on a wall
        // Adjust these values to position the image on your desired wall location
        imageEntity.position = SIMD3<Float>(0, 0, -0.5) // Example position
        
        // 6. Add the anchor entity to the scene
        self.scene.addAnchor(anchorEntity)
    }


}
