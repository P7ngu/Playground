import SwiftUI
import UIKit

struct GameViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = GameViewController
    
    func makeUIViewController(context: Context) -> GameViewController {
        // Initialize and configure your GameViewController
        let viewController = GameViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        // Update the view controller if needed
    }
}


