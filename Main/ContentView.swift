/*
 An app about poems and the environment

This app needs to be displayed on landscape mode, I forced it but Playground didn't like it, _at all_. So, dear human reading this, please use landscape mode.
 
 
 
 
 */

import SwiftUI

struct ContentView: View {
    @State private var colors: [Color] = [
        .green,
        .red,
        .blue
    ]
    
    var body: some View {
        ZStack {
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
                    }.padding()
                } 
        }
    }
}
