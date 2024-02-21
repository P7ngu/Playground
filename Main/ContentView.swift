/*
 An app about poems and the environment

This app needs to be displayed on landscape mode, I tried to force it but Playground didn't like it, _at all_.
 
 
 
 */

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @State private var sceneKey = UUID() // Meant to be used to force-recreate the SpriteKit
    
    
    func restartScene(){
      /*  DispatchQueue.main.asyncAfter(deadline: .now()){
            //new scene incoming
            if let scene = GameScene(fileNamed: "GameScene"){
                scene.scaleMode = .aspectFill
                //let's present it immediately
                self.view?.presentScene(scene)
            }
        }
       */
    }
    
    @State private var colors: [Color] = [
        .green,
        .red,
        .blue
    ]
    
    // Initializing the Game Scene
    var gameScene: GameScene {
        print("The game is not over")
        let scene = GameScene(size: CGSize(width: 1920, height: 1080))
        scene.scaleMode = .fill
        //scene.gameViewController = GameViewController()
        return scene
    }
    
    var body: some View {
        ZStack {
            if(!gameScene.isGameOver){
                SpriteView(scene: gameScene)
                    .id(sceneKey) // Change the ID to recreate the view
                    .ignoresSafeArea()
            } else {
                MyARViewRepresentable()
                    .ignoresSafeArea()
                    .overlay(alignment: .bottom) { } // To add some buttons if needed
                ScrollView(.horizontal){
                    HStack{
                        Button{
                            ARManager.shared.actionStream.send(.removeAllAnchors)
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding()
                                .background(.regularMaterial) //blurred effect
                                .cornerRadius(16.0)
                        }
                        
                        ForEach(colors, id: \.self){ color in
                            Button{
                                ARManager.shared.actionStream.send(.placeBlock(color: color))
                            } label: {
                                color
                                    .frame(width: 40, height: 40)
                                    .padding()
                                    .background(.regularMaterial) // blurred effect
                                    .cornerRadius(16.0)
                            }
                        }
                    }.padding()
                } 
                
            }
        }
    }
}
