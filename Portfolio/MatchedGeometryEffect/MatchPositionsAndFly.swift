//
//  MatchPositionsAndFly.swift
//  Portfolio
//
//  Created by Thibault Wittemberg on 2020-11-01.
//

import SwiftUI

struct MatchPositionsAndFly: View {
    @Namespace
    var animation

    @State
    var animate = false

    var body: some View {
        VStack {
            Circle()
                .matchedGeometryEffect(id: "fly", in: self.animation, isSource: self.animate ? true : false)
                .frame(width: 150, height: 150)
                .foregroundColor(self.animate ? .pink : .orange)

            Spacer()

            Circle()
                .matchedGeometryEffect(id: self.animate ? "fly" : "", in: self.animation, isSource: self.animate ? true : false)
                .frame(width: 200, height: 200)
                .foregroundColor(.pink)

            Spacer()

            Button("Fly") {
                withAnimation(.easeInOut) {
                    self.animate.toggle()
                }
            }
        }
    }
}

struct MatchPositionsAndFly_Previews: PreviewProvider {
    static var previews: some View {
        MatchPositionsAndFly()
    }
}
