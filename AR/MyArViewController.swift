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
        
        //AR configuration
        let configuration = ARWorldTrackingConfiguration()
        arView.session.run(configuration)
        

    }
    
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
}
