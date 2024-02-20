import SpriteKit
import GameplayKit
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate {
   //@ObservedObject var viewModel: SharedViewModel
    /*weak var gameViewController: GameViewController?
    func presentSwiftUIView() {
        DispatchQueue.main.async {
        }
        let swiftUIView = ContentView(isGameOver: true)
        let hostingController = UIHostingController(rootView: swiftUIView)
        // Present the view controller
        self.gameViewController?.present(hostingController, animated: true, completion: nil)
    }
     */
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var isGameOver = false
    
    private var lastUpdateTime : TimeInterval = 0
    private var storyLabel = SKLabelNode(fontNamed: "Chalkduster")
    private var storyLabelBGColor = SKSpriteNode()
    private var spinnyNode : SKShapeNode?
    private var canArray: [SKSpriteNode] = []
    private var gameScene = 0
    private var cameraNode: SKCameraNode = SKCameraNode()
    private var gradientBackground = SKSpriteNode()
    private var egg = SKSpriteNode()
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        addGround()
        addBackground()
        setupCamera()
        setupStoryLabel()
    }
    
    func setupStoryLabel() {
        storyLabel.text = "Once upon a time..."
        storyLabel.fontColor = UIColor.black
        storyLabel.position = (CGPoint(x:1920/2,  y:200))
        storyLabelBGColor = SKSpriteNode(color: UIColor.white, size: CGSize(width: storyLabel.frame.size.width + 50, height: storyLabel.frame.size.height + 25))
        storyLabelBGColor.zPosition = -1
        storyLabel.addChild(storyLabelBGColor)
        self.addChild(storyLabel)
    }
    
    func updateStoryLabel(newText: String){
        storyLabel.text = newText
        storyLabelBGColor.size = CGSize(width: storyLabel.frame.size.width + 50, height: storyLabel.frame.size.height + 25)
        
    }

    func spawnCans(){
        var xPosition = 220.0
        let yPosition = 140.0
            for _ in 1...13 {
                let can = SKSpriteNode(imageNamed: "can")
                can.zPosition = 3
                can.position.x = xPosition
                can.name = "Can"
                can.position.y = yPosition
                can.scale(to: CGSize(width: 300, height: 200))
                can.physicsBody = SKPhysicsBody(texture: can.texture!, size: can.size)
                //can.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
                can.physicsBody?.linearDamping = 8
                can.physicsBody?.affectedByGravity = true
                can.physicsBody?.categoryBitMask = 2
                //can.physicsBody?.collisionBitMask = 2
                addChild(can)
                canArray.append(can)
                xPosition += 120
        }
    }
    
    func addBackground(){
        gradientBackground = SKSpriteNode(imageNamed: "background2")
        gradientBackground.zPosition = -11
        gradientBackground.position.x = 1920/2
        gradientBackground.position.y = 1080/2
        addChild(gradientBackground)
    }
    
    @objc func addGround() {
        for _ in 0 ... 3 {
            let ground = SKSpriteNode(imageNamed: "ground2")
            ground.name = "Ground"
            let rectWidth = ground.size.width * 2
            let rectHeight = ground.size.height - 65
            let rectangle = CGSize(width: rectWidth, height: rectHeight)
            ground.physicsBody = SKPhysicsBody(rectangleOf: rectangle)
            ground.physicsBody!.isDynamic = false
            ground.physicsBody!.affectedByGravity = false
            ground.physicsBody!.categoryBitMask = 2
            ground.zPosition = 1
            ground.scale(to: CGSize(width: 1920, height: 120))
            ground.position = CGPoint(x: 1920/2, y: -250)
            addChild(ground)
        }
        
    }
    
    func addEgg(){
        egg = SKSpriteNode(imageNamed: "egg")
        egg.zPosition = 1
        egg.position.x = 1920/2
        egg.position.y = 240/2
        egg.scale(to: CGSize(width: 190, height: 150))
        addChild(egg)
    }
    
    func makeEggVisible(){
        egg.zPosition = 1
    }
    
    func removeEgg(){
        egg.zPosition = -30
    }
    
    func setupCamera() {
        cameraNode.position = CGPoint(x: 1920/2, y: 1080/2)
        addChild(cameraNode)
        camera = cameraNode
    }
    
    func zoomInCamera() {
        let zoomInAction = SKAction.scale(to: 0.5, duration: 1)
         cameraNode.position = CGPoint(x: 1920/2, y: 230)
         cameraNode.run(zoomInAction)
    }
    
    func zoomCamera(amount: CGFloat){
        let zoomOutAction = SKAction.scale(to: amount, duration: 1)
        cameraNode.run(zoomOutAction)
    }
    
    
    func zoomOutCamera() {
        let zoomOutAction = SKAction.scale(to: 1.2, duration: 1)
        cameraNode.run(zoomOutAction)
    }
    
    @objc func deleteUnusedObjects(){
        for node in children {
            if node.position.x < -900 {
                node.removeFromParent()
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        if nodeA.name == "Can" && nodeB.name == "Can"{
            canHit(nodeA)
            print("hit")
        } else {
            canHit(nodeB)
            print("else")
        }
        
    }
    
    func canHit(_ node: SKNode){
        node.removeFromParent()
    }
    
    func touchDown(atPoint pos : CGPoint) {
      
    }
    
    func touchUp(atPoint pos : CGPoint) {
     
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        print("tap")
        if tappedNodes.first?.name == "Can"{
            tappedNodes.first?.removeFromParent()
            if(!canArray.isEmpty) { //There are still some cans left
                 updateStoryLabel(newText: "Save it! Tap on the cans to remove them!")
                canArray.removeFirst()
                print("can removed")
            } 
        }else if (canArray.isEmpty && gameScene == 0){ //There are no cans left
            addEgg()
            zoomInCamera()
            updateStoryLabel(newText: "There was a lonely, lovely egg")
            gameScene = gameScene+1
        } else if(gameScene == 1){
            updateStoryLabel(newText: "It was forged in love")
            updateBackground(newBackground: "forged")
            gameScene = gameScene+1
        } else if(gameScene == 2){
            removeEgg()
            zoomCamera(amount: 0.7)
            updateStoryLabel(newText: "Different from everyone else, and meant for great things")
            updateBackground(newBackground: "great")
            gameScene = gameScene+1
        } else if(gameScene == 3){
             updateStoryLabel(newText: "Until one day, while the egg was growing brightly...")
             updateBackground(newBackground: "background2")
            gameScene = gameScene+1
            zoomCamera(amount: 0.9)
        } else if(gameScene == 4){
            updateStoryLabel(newText: "Trash started to poison its home")
            zoomCamera(amount: 1.0)
             gameScene = gameScene+1
            spawnCans()
        } else if (gameScene == 5){
             updateStoryLabel(newText: "Save it! Tap on the cans to remove them!")
            if(canArray.isEmpty) {gameScene = gameScene+1}
        } else if(gameScene == 6 && canArray.isEmpty){
            updateStoryLabel(newText: "You saved this egg, but penguins are still suffering")
            gameScene = gameScene+1
        } else if (gameScene == 7){
            updateStoryLabel(newText: "Look around you...")
            gameScene = gameScene+1
        } else if(gameScene == 8){
            //Change view, time for ARKit
            isGameOver = true
            print("AR Kit")
            transitionToARView()
        }
    }
    
    func arView(){
        
    }
    func transitionToARView() {
        guard let skView = self.view, let viewController = skView.window?.rootViewController else {
            print("Could not find the view controller.")
            return
        }
        
        let arViewController = MyARViewController()
        
        // Present the AR view controller
        viewController.present(arViewController, animated: true, completion: nil)
    }

    func updateBackground(newBackground: String){
        gradientBackground = SKSpriteNode(imageNamed: newBackground)
        gradientBackground.zPosition = -5
        gradientBackground.scale(to: CGSize(width: 1920, height: 1080))
        gradientBackground.position.x = cameraNode.position.x
        gradientBackground.position.y = cameraNode.position.y
        addChild(gradientBackground)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    

}


