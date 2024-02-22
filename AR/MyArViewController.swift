import UIKit
import SpriteKit
import ARKit
import SwiftUI

class MyARViewController: UIViewController {
    var arView: ARSCNView!
    
    @State private var colors: [Color] = [
        .green,
        .red,
        .blue
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView = ARSCNView(frame: self.view.bounds)
        self.view.addSubview(arView)
        
        let configuration = ARWorldTrackingConfiguration()
        arView.session.run(configuration)
        
        // Setup the rest of the AR scene 
        

    }
    
    func dismissViewController() {
        // Dismiss the view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
}
