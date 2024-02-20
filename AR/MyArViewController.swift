import UIKit
import SpriteKit
import ARKit

class MyARViewController: UIViewController {
    var arView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView = ARSCNView(frame: self.view.bounds)
        self.view.addSubview(arView)
        
        let configuration = ARWorldTrackingConfiguration()
        arView.session.run(configuration)
        
        // Setup the rest of your AR scene here
    }
    
  
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
}
