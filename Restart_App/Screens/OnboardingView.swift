//
//  OnboardingView.swift
//  Restart_App
//
//  Created by Manojkumar Bellatti on 19/08/22.
//

import SwiftUI
//import XCTest

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth : Double = UIScreen.main.bounds.width - 80 // To set the consttraints of the button
    @State private var buttonOffset : CGFloat = 0
    @State private var isAnimating : Bool = false
    @State private var imageOffset : CGSize = CGSize(width: 0, height: 0)
    @State private var Indicator : Double = 1.0
    @State private var textTitle : String = "Text"
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    // We will use this property to trigger a notification feedback by calling its particular built-in method
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack ( spacing: 20){
//            mark: header
                Spacer()
                
                VStack(spacing : 0){
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                        
                    
                    Text("""
It's not how much we give but how much love we put in giving it.
""")
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .padding(.horizontal, 10)
                    .opacity(30)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y :isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
//            mark : center
                ZStack{
                    CircleGroupView(ShapeOpacity: 0.2, ShapeColor: .white)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                   Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width/20)))
                        .gesture(
                        DragGesture()
                            .onChanged{
                                gesture in
                                if abs(imageOffset.width) <= 150
                                {
                                    imageOffset = gesture.translation
                                    
                                    withAnimation(.linear(duration: 0.1)){
                                        Indicator = 0
                                        textTitle = "Give"
                                    }
                                }
                            }
                            .onEnded{
                                 _ in
                                imageOffset = .zero
                                withAnimation(.linear(duration: 0.1))
                                {
                                    Indicator = 1
                                    textTitle = "Share"
            
                                }
                            }
                        )
                        .animation(.easeOut(duration:1), value: imageOffset)
                }
                .overlay(
                Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(.white)
                    .offset(y: 60)
                    .opacity(isAnimating ? 1 : 0)
                    .opacity(Indicator)
                    .animation(.easeOut(duration: 1).delay(1), value: isAnimating)
                    , alignment: .bottom
                    
                )
                .padding(45)
                Spacer()
//            mark : footer
                ZStack{
                    // parts of the footer section
                    //1.background(static)
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                        
                    //2.call to action(static)
                    Text("Get Started")
                        .font(.system(.title3,design: .rounded))
                        .offset(x :10	)
                    //3.capsule (dynamic width)
                    HStack
                    {
                        Capsule()
                        .fill(Color("ColorRed"))
                        .frame(width: buttonOffset + 80)
                    
                Spacer()
                    }
                    //4.actual button circle (draggable)
                    
                    HStack {
                        ZStack{
                            Circle()
                            .fill(Color("ColorRed"))
                            Circle()
                            .fill(.black.opacity(0.15))
                            .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24,weight: .bold))
                            
                            
                        }// button
                        .foregroundColor(.white)
                    .frame(width: 80, height: 80, alignment: .center)
                    .offset(x : buttonOffset)
                    .gesture(
                    DragGesture()
                        .onChanged{
                            gesture in
                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 20{
                                buttonOffset = gesture.translation.width
                            }
                        }
                        .onEnded{ _ in
                            withAnimation(Animation.easeOut(duration: 0.5)){
                                if buttonOffset > buttonWidth/2{
                                    hapticFeedback.notificationOccurred(.success)
                                    playSound(sound: "chimeup", type: "mp3")
                                    buttonOffset = buttonWidth - 20
                                    isOnboardingViewActive = false
                                }else{
                                    hapticFeedback.notificationOccurred(.warning)
                                    buttonOffset = 0
                                }
                            }
                            //buttonOffset = 0
                        }
                    )
                        Spacer()
                    }
                }//footer end
                .frame( height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y :isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                }//vstack
            }//zstack
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
        }
    }
    
    


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
