import SwiftUI
import SpriteKit

@main
struct MyApp: App {
    var gameScene: GameScene {
        let scene = GameScene(size: CGSize(width: 1920, height: 1080))
        scene.scaleMode = .fill
        return scene
    }
    var body: some Scene {
        WindowGroup {
          SpriteView(scene: gameScene)
        }
    }
}
