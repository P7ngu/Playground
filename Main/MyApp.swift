import SwiftUI
import SpriteKit
import AVFoundation


@main
struct MyApp: App {
    @State var sceneStatus = 0
    
    var gameScene: GameScene {
        let scene = GameScene(size: CGSize(width: 1920, height: 1080))
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                SpriteView(scene: gameScene)
                if sceneStatus == 0 {
                    SingleLine()
                } else {
                    LongPressView()
                }
                //SpriteView(scene: GameScene_old(size: CGSize(width: 1920, height: 1080)))
                VStack {
                     Text("hello")
                    Text(String(sceneStatus))
                    Button("++"){
                        Task {
                            sceneStatus = 1
                        }
                    }
                   
                }
            }
        }
    }
}
