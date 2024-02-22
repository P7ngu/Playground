import SpriteKit
import GameplayKit
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate {
    public var isGameOver = false
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var storyLabel = SKLabelNode(fontNamed: "ChalkboardSE-Regular")
    private var instructionLabel = SKLabelNode(fontNamed: "ChalkboardSE-Regular ")
    private var storyLabelBGColor = SKSpriteNode()
    private var instructionLabelBGColor = SKSpriteNode()
    private var scoreLabel = SKLabelNode(fontNamed: "ChalkboardSE-Regular ")
    
    var score = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }

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
        setupInstructionLabel()
    }
    
    func hideInstructionLabel() {
        instructionLabel.zPosition = -200
    }
    
    func hideStoryLabel() {
        storyLabel.zPosition = -230
    }
    
    func makeInstructionFlash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.instructionLabel.zPosition = -10
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.instructionLabel.zPosition = 10
        }
    }
    
    func setupScoreLabel(){
        scoreLabel.text = "Score: "
        scoreLabel.zPosition = 15
        scoreLabel.fontColor = .white
        scoreLabel.position.x = 1920/5
        scoreLabel.position.y = 400
        addChild(scoreLabel)
    }
    
    func updateScoreLabel(){
        print("updating score label")
        scoreLabel.text = "Score: \(score)"

    }
    
    func setupInstructionLabel() {
        instructionLabel.text = "Tap the screen to continue"
        instructionLabel.position = (CGPoint(x: 1920/8, y: 600))
        instructionLabel.zPosition = 5
        instructionLabel.fontColor = .blue
        instructionLabelBGColor = SKSpriteNode(color: UIColor.white, size: CGSize(width: instructionLabel.frame.size.width + 5, height: instructionLabel.frame.size.height + 15))
        instructionLabelBGColor.zPosition = -1
        instructionLabel.addChild(instructionLabelBGColor)
        self.addChild(instructionLabel)

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
    
    func removeEggs() {
        for node in children {
            if node.name == "normalEgg" {
                node.removeFromParent()
            }
        }
    }
    
    func spawnEggs() {
        var xPosition = 620.0
        let yPosition = -30.0
        for i in 1...5 {
            if (i != 3){
            let normalEgg = SKSpriteNode(imageNamed: "Normal-egg")
            normalEgg.zPosition = 3
            normalEgg.name = "normalEgg"
            normalEgg.physicsBody = SKPhysicsBody(texture: normalEgg.texture!, size: normalEgg.size)
            normalEgg.physicsBody?.affectedByGravity = false
            normalEgg.position.x = xPosition
            normalEgg.position.y = yPosition
            normalEgg.scale(to: CGSize(width: 300, height: 200))
            addChild(normalEgg)
        } 
             xPosition += 190
        }
    }

    func spawnCans(){
        var xPosition = 220.0
        let yPosition = 100.0
            for _ in 1...12 {
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
                xPosition += 140
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
            ground.position = CGPoint(x: 1920/2, y: -340)
            addChild(ground)
        }
        
    }
    
    func addEgg(){
        egg = SKSpriteNode(imageNamed: "egg")
        egg.zPosition = 1
        egg.position.x = 1920/2
        egg.position.y = 240/2
        egg.scale(to: CGSize(width: 190, height: 150))
        //egg.physicsBody = SKPhysicsBody(texture: egg.texture!, size: egg.size)
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
            score = score+1
            updateScoreLabel()
            tappedNodes.first?.removeFromParent()
            if(!canArray.isEmpty) { //There are still some cans left
                 updateStoryLabel(newText: "Save it! Tap on the cans to remove them!")
                triggerSimpleHaptic()
                canArray.removeFirst()
                print("can removed")
            } 
        } else if (canArray.isEmpty && gameScene == 0){ //There are no cans left
            addEgg()
            zoomInCamera()
            updateStoryLabel(newText: "There was a lonely, lovely colorful egg")
            gameScene = gameScene+1
            triggerSimpleHaptic()
            hideInstructionLabel()
        } else if(gameScene == 1){
            triggerSimpleHaptic()
            updateStoryLabel(newText: "It was forged in love")
            updateBackground(newBackground: "forged")
            gameScene = gameScene+1
            triggerSimpleHaptic()
        } else if(gameScene == 2){
            zoomCamera(amount: 0.7)
            updateStoryLabel(newText: "Different from every other egg, and meant for great things")
            updateBackground(newBackground: "background2")
            spawnEggs()
            gameScene = gameScene+1
            triggerSimpleHaptic()
        } else if(gameScene == 3){
            removeEggs()
             updateStoryLabel(newText: "Until one day, while the egg was growing brightly...")
             updateBackground(newBackground: "background2")
            gameScene = gameScene+1
            triggerSimpleHaptic()
            zoomCamera(amount: 0.9)
        } else if(gameScene == 4){
            updateStoryLabel(newText: "Trash started to poison its home")
            zoomCamera(amount: 1.0)
            triggerSimpleHaptic()
             gameScene = gameScene+1
            spawnCans()
        } else if (gameScene == 5){
             updateStoryLabel(newText: "Save it! Tap on the cans to remove them!")
            if(canArray.isEmpty) {gameScene = gameScene+1}
        } else if(gameScene == 6 && canArray.isEmpty){
            updateStoryLabel(newText: "You saved this one egg, but penguins are still suffering")
            triggerSimpleHaptic()
            gameScene = gameScene+1
        } else if (gameScene == 7){
            updateStoryLabel(newText: "Look around you...")
            gameScene = gameScene+1
            triggerSimpleHaptic()
        } else if(gameScene == 8){
            //Change view, time for ARKit
            hideStoryLabel()
            isGameOver = true
            print("AR Kit")
            //transitionToARView()
            presentSwiftUIView()
            gameScene = gameScene+1
        } else if(gameScene == 9){
            print("End of AR")
             //updateStoryLabel(newText: "Our world is suffering too. We have to do something!")
             gameScene = gameScene+1
            removeEgg()
            updateBackground(newBackground: "penguin")
            triggerSimpleHaptic()
        } else if(gameScene == 10){
            print("Endgame starts now")
            setupScoreLabel()
            score = 0
            spawnCans()
            gameScene = gameScene+1
        } else if(gameScene == 11){
            if(score % 12 == 0){
                spawnCans()
                isGameOver.toggle()
                gameScene = gameScene+1
            }
        }
    }
    
    func triggerSimpleHaptic() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        // Trigger the feedback after some game event
        feedbackGenerator.impactOccurred()
    }
    
    func presentSwiftUIView() {
        // Find the current view controller
        if let viewController = self.view?.findViewController() {
            // Create the SwiftUI view to present
            let swiftUIView = ContentView()
            // Wrap the SwiftUI view in a UIHostingController
            let hostingController = UIHostingController(rootView: swiftUIView)
            
            // Present the view controller
            viewController.present(hostingController, animated: true, completion: nil)
        }
    }

    func transitionToARView() {
        guard let skView = self.view, let viewController = skView.window?.rootViewController else {
            print("Could not find the view controller.")
            return
        }
        
        let arViewController = MyARViewController()
        
        // Present the AR view controller
        viewController.present(arViewController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
           arViewController.dismiss(animated: true, completion: nil)
        }
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
        let _ = currentTime - self.lastUpdateTime

        
        self.lastUpdateTime = currentTime
    }
    


}

extension UIResponder {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}


