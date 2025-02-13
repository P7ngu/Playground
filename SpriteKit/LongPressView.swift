import SwiftUI
//#-learning-task(longPressView)

/*#-code-walkthrough(2.capsule)*/
struct LongPressView: View {
    /*#-code-walkthrough(2.capsule)*/
    /*#-code-walkthrough(2.setUp)*/
    @State private var sizeIndex = 0
    //#-learning-code-snippet(defineDetectingLongPress)
    
    private var sizes: [CGSize] = [
        CGSize(width: 150, height: 80),
        CGSize(width: 200, height: 40),
        CGSize(width: 50, height: 250),
        CGSize(width: 220, height: 100),
        CGSize(width: 90, height: 90),
    ]
    /*#-code-walkthrough(2.setUp)*/
    
    /*#-code-walkthrough(2.longPress)*/
    var longPressGesture: some Gesture {
        LongPressGesture()
        /*#-code-walkthrough(2.onEndedEvent)*/
            .onEnded { value in
                withAnimation {
                    sizeIndex += 1
                    if sizeIndex == sizes.count {
                        sizeIndex = 0
                    }
                }
                /*#-code-walkthrough(2.onEndedEvent)*/
            }
        //#-learning-code-snippet(addUpdatingHandler)
    }
    /*#-code-walkthrough(2.longPress)*/
    
    var body: some View {
        VStack {
            Spacer()
            Capsule()
                .foregroundColor(.yellow)
            /*#-code-walkthrough(2.frame)*/
                .frame(width: sizes[sizeIndex].width, height: sizes[sizeIndex].height)
            /*#-code-walkthrough(2.frame)*/
            /*#-code-walkthrough(2.applyingTheSize)*/
                .gesture(longPressGesture)
            
            /*#-code-walkthrough(2.applyingTheSize)*/
            //#-learning-code-snippet(changeShadowRadius)
            
            //#-learning-code-snippet(addRoundedRect)
            
            Spacer()
        }
        .navigationTitle("Touch and Hold")
        .frame(maxWidth: .infinity)
        .overlay(alignment: .top) {
            Text("Touch and hold the capsule to change its size")
                .padding()
        }
        .padding(.trailing)
        .toolbar {
            Button("Reset") {
                sizeIndex = 0
            }
        }
    }
}

struct LongPressView_Previews: PreviewProvider {
    static var previews: some View {
        LongPressView()
    }
}


extension Color {
    static let shadowColor = Color("shadowColor")
    
}
