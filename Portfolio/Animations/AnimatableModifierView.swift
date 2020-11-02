//
//  TestView.swift
//  SwiftUI3D
//
//  Created by Thibault Wittemberg on 2020-05-24.
//  Copyright © 2020 Spinners. All rights reserved.
//

import SwiftUI

struct AnimatableModifierView: View {

    @State
    var toggle = false

    var body: some View {
        Rectangle()
        .frame(width: 200, height: 200)
            .foregroundColor(.pink)
            .modifier(AnimatableText(pct: self.toggle ? 100 : 0))
            .animation(.easeInOut)
            .onTapGesture {
                self.toggle.toggle()
        }
    }
}

struct AnimatableText: AnimatableModifier {

    var pct: Double

    var animatableData: Double {
        get { pct }
        set { self.pct = newValue }
    }

    func body(content: Content) -> some View {
        content
            .overlay(Text("\(self.pct)%").foregroundColor(.white))
    }
}

struct AnimatableModifierView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatableModifierView()
    }
}
