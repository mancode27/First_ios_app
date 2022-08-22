//
//  CircleGroupView.swift
//  Restart_App
//
//  Created by Manojkumar Bellatti on 20/08/22.
//

import SwiftUI

struct CircleGroupView: View {
    // Resusable Components
    // helps us to use this same ring in different background color and opacity but the size remains same.
 @State var ShapeOpacity : Double
 @State var ShapeColor : Color
    @State private var isAnimating : Bool = false
    // mark : body
    var body: some View {
        ZStack{
          Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity),lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
          Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity),lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        }
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeInOut(duration: 1), value: isAnimating)
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all,edges: .all)
                
            CircleGroupView(ShapeOpacity: 0.2, ShapeColor: .white)
        }
    }
}
