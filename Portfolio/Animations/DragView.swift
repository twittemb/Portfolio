//
//  ContentView.swift
//  SwiftUI3D
//
//  Created by Thibault Wittemberg on 2020-03-02.
//  Copyright © 2020 Spinners. All rights reserved.
//

import SwiftUI

struct DragView: View {

    @State
    var dragAmount = CGSize.zero

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 300, height: 300)
                .rotation3DEffect(.degrees(-Double(self.dragAmount.width) / 20), axis: (x: 0, y: 1, z:0))
                .rotation3DEffect(.degrees(Double(self.dragAmount.height) / 20), axis: (x: 1, y: 0, z:0))
                .offset(self.dragAmount)
                .gesture(DragGesture()
                    .onChanged {
                        self.dragAmount = $0.translation
                }
                .onEnded { _ in
                    withAnimation(.spring()) {
                        self.dragAmount = .zero
                    }
                }
            )
        }
    }
}

struct DragView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
