//
//  MatchPositionsView.swift
//  Portfolio
//
//  Created by Thibault Wittemberg on 2020-11-01.
//

import SwiftUI

struct MatchPositionsView: View {
    @Namespace
    var animation

    @State
    var drag = CGSize.zero

    var body: some View {
        ZStack {
            Circle().foregroundColor(.blue).frame(width: 250, height: 250)
                .zIndex(3)
                .offset(y: -200)
                .matchedGeometryEffect(id: "drag", in: self.animation, properties: .position, isSource: false)
                .animation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.1))

            Circle().foregroundColor(.green).frame(width: 200, height: 200)
                .zIndex(4)
                .offset(x: 100, y: 130)
                .matchedGeometryEffect(id: "drag", in: self.animation, properties: .position, isSource: false)
                .animation(.spring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.2))

            Circle().foregroundColor(.orange).frame(width: 150, height: 150)
                .zIndex(5)
                .offset(x: -100, y: -100)
                .matchedGeometryEffect(id: "drag", in: self.animation, properties: .position, isSource: false)
                .animation(.spring(response: 0.7, dampingFraction: 0.5, blendDuration: 0.5))

            Circle().foregroundColor(.purple).frame(width: 150, height: 150)
                .zIndex(5)
                .offset(x: -100, y: 100)
                .matchedGeometryEffect(id: "drag", in: self.animation, properties: .position, isSource: false)
                .animation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.1))

            Circle().foregroundColor(.red).frame(width: 110, height: 110)
                .zIndex(5)
                .offset(x: 100, y: -20)
                .matchedGeometryEffect(id: "drag", in: self.animation, properties: .position, isSource: false)
                .animation(.spring(response: 0.9, dampingFraction: 0.3, blendDuration: 0.5))

            Circle().foregroundColor(.yellow).frame(width: 100, height: 100)
                .zIndex(5)
                .offset(x: -10, y: 150)
                .matchedGeometryEffect(id: "drag", in: self.animation, properties: .position, isSource: false)
                .animation(.spring(response: 0.3, dampingFraction: 0.9, blendDuration: 05))

            Circle()
                .matchedGeometryEffect(id: "drag", in: self.animation, properties: .position, isSource: true)
                .foregroundColor(.gray)
                .frame(width: 100, height: 100)
                .offset(x: self.drag.width, y: self.drag.height)
                .overlay(Text("Drag").offset(x: self.drag.width, y: self.drag.height))
                .gesture(DragGesture().onChanged({ (value) in
                    self.drag = value.translation
                }).onEnded({ _ in
                    withAnimation(.spring()) {
                        self.drag = .zero
                    }
                }))
        }
    }
}

struct MatchPositionsView_Previews: PreviewProvider {
    static var previews: some View {
        MatchPositionsView()
    }
}
