import SwiftUI

struct SingleLine: View {
    
    @State var lineStart = CGPoint.zero
    @State var lineEnd = CGPoint.zero
 
    var lineDrawingGesture: some Gesture {
        DragGesture()
        
            .onChanged { value in
                lineStart = value.startLocation
                lineEnd = value.location
                  //Use this to understand if the line placement was good enough
            }
       
            .onEnded { value in
                lineEnd = value.location
                
            }
        
    }
    
    
    var body: some View {
        ZStack {
            
            Path { path in
                path.move(to: lineStart)
                path.addLine(to: lineEnd)
            }
            
            .stroke(Color.accentColor, lineWidth: 8.0)
            .contentShape(Rectangle())
           
            
        }
        .gesture(lineDrawingGesture)
        .navigationTitle("Line Drawing")
        .overlay(alignment: .top) {
            Text("Touch and drag to make a line")
                .padding()
        }
        .padding()
        .toolbar {
            Button("Reset") {
                lineStart = .zero
                lineEnd = .zero
            }
        }
    }
}

struct SingleLine_Previews: PreviewProvider {
    static var previews: some View {
        SingleLine()
    }
}

