//An app about poems and the environment
//Created by Matteo Perotta - 9 Feb 2024

import SwiftUI
import SpriteKit

struct ExtArView: View {
    
    @State public var isGameOver = false {
        didSet{
           // restartScene()
        }
    }

    
    @State public var colors: [Color] = [
        .green,
        .red,
        .blue
    ]
    
    func changeGameOverStatus() {
        isGameOver.toggle()
    }
    
    
    var body: some View {
        ZStack {
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
                
            }
        }
    }
}

