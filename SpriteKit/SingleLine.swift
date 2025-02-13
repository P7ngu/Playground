import SwiftUI
//#-learning-task(singleLineView)

/*#-code-walkthrough(6.singleLineView)*/
struct SingleLine: View {
    /*#-code-walkthrough(6.singleLineView)*/
    /*#-code-walkthrough(6.setUp)*/
    //#-learning-code-snippet(pathStateProperty)
    @State var lineStart = CGPoint.zero
    @State var lineEnd = CGPoint.zero
    /*#-code-walkthrough(6.setUp)*/
    /*#-code-walkthrough(6.dragGesture)*/
    var lineDrawingGesture: some Gesture {
        DragGesture()
        /*#-code-walkthrough(6.onChanged)*/
            .onChanged { value in
                lineStart = value.startLocation
                lineEnd = value.location
                //#-learning-code-snippet(moveToStartLocation)
            }
        /*#-code-walkthrough(6.onChanged)*/
        /*#-code-walkthrough(6.onEnded)*/
            .onEnded { value in
                lineEnd = value.location
                //#-learning-code-snippet(addLineToPath)
            }
        /*#-code-walkthrough(6.onEnded)*/
    }
    /*#-code-walkthrough(6.dragGesture)*/
    
    var body: some View {
        ZStack {
            /*#-code-walkthrough(6.path)*/
            Path { path in
                path.move(to: lineStart)
                path.addLine(to: lineEnd)
            }
            /*#-code-walkthrough(6.path)*/
            .stroke(Color.accentColor, lineWidth: 8.0)
            .contentShape(Rectangle())
            //#-learning-code-snippet(addOpacity)
            
            //#-learning-code-snippet(addDrawing)
        }
        /*#-code-walkthrough(6.applyingTheValues)*/
        .gesture(lineDrawingGesture)
        /*#-code-walkthrough(6.applyingTheValues)*/
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
                //#-learning-code-snippet(resetYourDrawing)
            }
        }
    }
}

struct SingleLine_Previews: PreviewProvider {
    static var previews: some View {
        SingleLine()
    }
}

