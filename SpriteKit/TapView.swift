import SwiftUI
//#-learning-code-snippet(tapView)

/*#-code-walkthrough(1.tapView)*/
struct TapView: View {
    /*#-code-walkthrough(1.tapView)*/
    //#-learning-code-snippet(experimentScaleP1)
    
    /*#-code-walkthrough(1.setUp)*/
    @State private var color : Color = Color.primary
    /*#-code-walkthrough(1.setUp)*/
    
    /*#-code-walkthrough(1.tapGesture)*/
    var tapGesture: some Gesture {
        /*#-code-walkthrough(1.gestureDefinition)*/
        /*#-code-walkthrough(tapGestureParams)*/
        TapGesture()
        /*#-code-walkthrough(tapGestureParams)*/
            .onEnded {
                withAnimation {
                    color = Color.random()
                    //#-learning-code-snippet(experimentScaleP2)
                }
            }
        /*#-code-walkthrough(1.gestureDefinition)*/
    }
    /*#-code-walkthrough(1.tapGesture)*/
    
    var body: some View {
        VStack {
            Spacer()
            /*#-code-walkthrough(1.rectangle)*/
            Rectangle()
            /*#-code-walkthrough(1.rectangle)*/
            /*#-code-walkthrough(1.foregroundColor)*/
                .foregroundColor(color)
            /*#-code-walkthrough(1.foregroundColor)*/
                .frame(width: 250, height: 350)
            /*#-code-walkthrough(1.applyingTheColor)*/
                .gesture(tapGesture)
            /*#-code-walkthrough(1.applyingTheColor)*/
            //#-learning-code-snippet(experimentScaleP3)
            //#-learning-code-snippet(addCircle)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
        .overlay(alignment: .top) {
            Text("Tap the rectangle to change its color")
                .padding()
        }
        .navigationTitle("Tap")
        .toolbar {
            Button("Reset") {
                color = Color.primary
            }
        }
    }
}

struct TapView_Previews: PreviewProvider {
    static var previews: some View {
        TapView()
    }
}

extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}


