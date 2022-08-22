//
//  HomeView.swift
//  Restart_App
//
//  Created by Manojkumar Bellatti on 19/08/22.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimating : Bool = false
    var body: some View {
        VStack( spacing: 20) {
            
//            mark : header
            
            Spacer()
            ZStack{
                CircleGroupView(ShapeOpacity: 0.1, ShapeColor: .gray)
            Image("character-2")
                .resizable()
                .scaledToFit()
                .padding(13)
                .offset( y : isAnimating ? -35 : 35)
                .animation(Animation
                    .easeInOut(duration: 3.5)
                    .repeatForever(), value: isAnimating)
            }
//            mark : center
            Text("Pyaar vyar dhoka hai, padhlo beta mauka hai ~ Satyavachan by Manojkumar Bellatti")
                .multilineTextAlignment(.center)
                .font(.title2)
                .foregroundColor(.secondary)
                .padding(5)
                 Spacer()
            
//            mark : footer
            
            
            Button(action: {
              // some code
                withAnimation{
                    playSound(sound: "success", type: "m4a")
                    isOnboardingViewActive = true
                }
            }){
                Image(systemName:"arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                
                Text("Restart")
                    .font(.system(size: 24, design: .rounded))
                    .fontWeight(.bold)
            }// Button
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .padding()
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                isAnimating = true
            })
        })
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
