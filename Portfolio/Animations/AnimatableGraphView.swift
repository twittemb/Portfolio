//
//  GraphView.swift
//  SwiftUI3D
//
//  Created by Thibault Wittemberg on 2020-05-23.
//  Copyright © 2020 Spinners. All rights reserved.
//

import SwiftUI

struct AnimatableGraphView: View {
    @State
    var animate = false

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .center) {
                Button {
                    if self.animate {
                        withAnimation(.easeInOut) {
                            self.animate.toggle()
                        }
                    } else {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.2, blendDuration: 0)) {
                            self.animate.toggle()
                        }
                    }
                } label: {
                    Text("Click to animate")
                }

                GraphShape(pct: self.animate ? 1 : 0, values: [50, 23, 34, 56, 33, 76, 45, 52, 55, 60, 43, 35, 36, 37, 40, 45, 56,
                                                               67, 56, 33, 76, 45, 52, 55, 60, 43, 35, 50, 23, 34, 56, 33, 76, 45])
                    .stroke(lineWidth: 3)
                    .foregroundColor(.pink)
                    .frame(width: 300, height: 300, alignment: .center)
            }
        }

    }
}

// Shape already conforms to Animatable. It will interpolate all the values for animatableData and
// call path(in:) each time the animatableData changes
// https://swiftui-lab.com/swiftui-animations-part1/
struct GraphShape: Shape {

    var pct: Double
    let values: [Double]

    var animatableData: Double {
        get { self.pct }
        set { self.pct = newValue }
    }

    func path(in rect: CGRect) -> Path {

        let abscisseGraduation = CGFloat(rect.width) / CGFloat(self.values.count - 1)
        let ordonneeLength = self.values.max()!
        let originX = CGFloat(0)
        let originY = rect.origin.y + (rect.height / 2) + (CGFloat(ordonneeLength) / 2)
        let origin = CGPoint(x: originX, y: originY)

        var path = Path()
        path.move(to: CGPoint(x: CGFloat(origin.x), y: origin.y - CGFloat(values[0] * self.pct)))
        var idx: CGFloat = 0
        values.forEach { value in
            path.addLine(to: CGPoint(x: origin.x + CGFloat(idx), y: origin.y - CGFloat(value * self.pct)))
            idx += abscisseGraduation
        }

        path.move(to: CGPoint(x: originX, y: originY - CGFloat(ordonneeLength)))
        path.addLine(to: CGPoint(x: originX, y: originY))
        path.addLine(to: CGPoint(x: rect.width, y: originY))

        return path
    }
}

struct AnimatableGraphView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatableGraphView()
    }
}
