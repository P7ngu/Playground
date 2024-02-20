//An app about poems and the environment
//Created by Matteo Perotta - 9 Feb 2024

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @State private var sceneKey = UUID() // Used to force-recreate the SpriteView
    
    @State public var isGameOver = false {
        didSet{
            restartScene()
        }
    }
    
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
    
    func changeGameOverStatus() {
        isGameOver.toggle()
    }
    
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
                    .overlay(alignment: .bottom) { }//To add some buttons 
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
                                    .background(.regularMaterial) //blurred effect
                                    .cornerRadius(16.0)
                            }
                        }
                    }.padding()
                } .onChange(of: isGameOver) { _ in
                    if isGameOver {
                        // Reset or change the game scene when the game is over
                        self.sceneKey = UUID() // Change the key to force-recreate the SpriteView
                    }
                }
                
            }
        }
    }
}
