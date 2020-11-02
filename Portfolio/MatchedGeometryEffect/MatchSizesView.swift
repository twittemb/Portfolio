//
//  MatchSizesView.swift
//  Portfolio
//
//  Created by Thibault Wittemberg on 2020-11-01.
//

import SwiftUI

struct MatchSizesView: View {

    @Namespace
    var animation

    @State
    var scale: CGFloat = 1.0

    var body: some View {

        VStack {
            HStack {
                Circle()
                    .matchedGeometryEffect(id: "pinch", in: self.animation, properties: .size, isSource: false)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.blue)
                Spacer()
            }

            HStack {
                Spacer()

                Circle()
                    .matchedGeometryEffect(id: "pinch", in: self.animation, properties: .size, isSource: true)
                    .frame(width: 150 * self.scale, height: 150 * self.scale)
                    .foregroundColor(.pink)
                    .overlay(Text("Pinch").scaleEffect(self.scale))
                    .gesture(MagnificationGesture()
                                .onChanged({ factor in
                                    self.scale = factor / 2
                                })
                                .onEnded({ _ in
                                    withAnimation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.2)) {
                                        self.scale = 1.0
                                    }
                                }))

                Spacer()
            }

            HStack {
                Spacer()

                Circle()
                    .matchedGeometryEffect(id: "pinch", in: self.animation, properties: .size, isSource: false)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct MatchSizesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchSizesView()
    }
}
