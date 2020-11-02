//
//  FlipCardRotationShape.swift
//  SwiftUI3D
//
//  Created by Thibault Wittemberg on 2020-05-21.
//  Copyright © 2020 Spinners. All rights reserved.
//

import SwiftUI

struct FlipCardRotationView: View {
    @State
    var rotate = false

    @State
    var translation = CGSize.zero

    @State
    var midPercentage = false

    var body: some View {
        HStack {

            Spacer()

            VStack {

                Spacer()

                Image(self.midPercentage ? "avatar" : "startrek")
                    .resizable()
                    .frame(width: 300, height: 200)
                    .overlay(Text("Avatar").font(.title).fontWeight(.heavy).foregroundColor(Color.black.opacity(0.5)).offset(x: CGFloat(self.translation.width / 20), y: CGFloat(-self.translation.height / 20)))
                    .overlay(Text("Avatar").font(.title).fontWeight(.heavy).foregroundColor(.white).offset(x: CGFloat(-self.translation.width / 10), y: CGFloat(self.translation.height / 10)))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .rotation3DEffect(.degrees(self.rotate ? 180 : 0), axis: (x: 0, y: 5, z: 0))
                    .overlay(RotationShape(angle: self.rotate ? 180 : 0, flipped: self.$midPercentage))
                    .rotation3DEffect(.degrees(Double(-self.translation.height / 20)), axis: (x: 1, y: 0, z: 0))
                    .rotation3DEffect(.degrees(Double(self.translation.width / 20)), axis: (x: 0, y: 1, z: 0))
                    .animation(Animation.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                    .onTapGesture {
                        self.rotate.toggle()
                }

                    .gesture(DragGesture()
                        .onChanged { value in
                            self.translation = value.translation
                    }
                    .onEnded { _ in
                        self.translation = .zero
                    })

                Spacer()

                Button(action: {
                    self.rotate.toggle()
                }) {
                    Text("Rotate")
                }
                .offset(y: -50)

            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct RotationShape: Shape {

    var angle: Double
    let emptyPath = Path()
    @Binding var flipped: Bool

    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }

    func path(in rect: CGRect) -> Path {
        DispatchQueue.main.async {
            self.flipped = self.angle >= 90 && self.angle < 270
        }

        return emptyPath
    }
}

struct FlipCardRotationView_Previews: PreviewProvider {
    static var previews: some View {
        FlipCardRotationView()
    }
}
