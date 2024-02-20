import SwiftUI

struct MyARViewRepresentable: UIViewRepresentable{
    func makeUIView(context: Context) -> MyARView {
        return MyARView()
    }
    
    func updateUIView(_ uiView: MyARView, context: Context) {
        
    }
    
}
