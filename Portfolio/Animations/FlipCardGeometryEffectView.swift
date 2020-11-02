//
//  FlipCardGeometryEffectView.swift
//  SwiftUI3D
//
//  Created by Thibault Wittemberg on 2020-05-24.
//  Copyright © 2020 Spinners. All rights reserved.
//

import SwiftUI

struct FlipCardGeometryEffectView: View {
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
                        .modifier(FlipEffect(flipped: self.$midPercentage, angle: self.rotate ? 180 : 0))
                        .rotation3DEffect(.degrees(Double(-self.translation.height / 20)), axis: (x: 1, y: 0, z: 0))
                        .rotation3DEffect(.degrees(Double(self.translation.width / 20)), axis: (x: 0, y: 1, z: 0))
                        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))

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

// GeometryEffect conforms to both Animatable (which enforce to implement animatableData, and to ViewModifier, which allows to
// give it as a modifier in a view). The effectValue function will be called each time the animatableData changes. As it is an
// animatableData, SwiftUI will interpolate all the values
// https://swiftui-lab.com/swiftui-animations-part2/
struct FlipEffect: GeometryEffect {

    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }

    @Binding var flipped: Bool
    var angle: Double

    func effectValue(size: CGSize) -> ProjectionTransform {

        // We schedule the change to be done after the view has finished drawing,
        // otherwise, we would receive a runtime error, indicating we are changing
        // the state while the view is being drawn.
        DispatchQueue.main.async {
            self.flipped = self.angle >= 90 && self.angle < 270
        }

        let rotationAngle = CGFloat(Angle(degrees: self.angle).radians)

        var transform3d = CATransform3DIdentity;
        transform3d.m34 = -1/max(size.width, size.height)

        transform3d = CATransform3DRotate(transform3d, rotationAngle, 0, 5, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)

        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))

        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}

struct FlipCardGeometryEffectView_Previews: PreviewProvider {
    static var previews: some View {
        FlipCardGeometryEffectView()
    }
}
