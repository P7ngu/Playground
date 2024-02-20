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
    
    func dismissViewController() {
        // Perform any cleanup or additional actions here
        
        // Dismiss the view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
}
