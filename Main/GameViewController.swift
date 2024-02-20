import UIKit
import SpriteKit
import SwiftUI

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Configure and present your SKScene here
            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            scene.gameViewController = self // Provide a way for the scene to reference this controller if needed
        }
    }
    
    func presentSwiftUIView() {
        // Create a SwiftUI view
        let newView = ContentView()
        
        // Wrap the SwiftUI view in a UIHostingController
        let hostingController = UIHostingController(rootView: newView)
        
        // Present the UIHostingController
        self.present(hostingController, animated: true, completion: nil)
    }
}




