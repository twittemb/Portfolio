//
//  MatchFrameInGrid.swift
//  Portfolio
//
//  Created by Thibault Wittemberg on 2020-11-01.
//

import SwiftUI

struct MatchFrameInGrid: View {
    let colors: [Color] = [.blue, .gray, .green, .orange, .pink, .purple, .red, .yellow, .green, .orange, .pink, .blue, .gray, .purple, .red]

    @Namespace
    var animation

    @Namespace
    var animationContainer

    @State
    var selected: Int? = nil

    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: [GridItem(.fixed(200)), GridItem(.fixed(200))]) {
                    ForEach(0..<10) { index in
                        if index == self.selected {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(height: 200)
                        } else {
                            VStack {
                                Rectangle()
                                    .matchedGeometryEffect(id: "card\(index)", in: self.animation)
                                    .foregroundColor(self.colors[index])
                                    .frame(height: 200)
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.3)) {
                                            self.selected = index
                                        }
                                    }

                                Rectangle()
                                    .matchedGeometryEffect(id: "card\(index)", in: self.animationContainer)
                                    .foregroundColor(.clear)
                                    .frame(height: 0.0)
                            }
                        }
                    }
                }
            }

            if let selected = self.selected {
                ScrollView(.vertical) {
                    VStack {
                        ZStack(alignment: .topTrailing) {
                            ZStack(alignment: .bottomTrailing) {
                                Rectangle()
                                    .matchedGeometryEffect(id: "card\(selected)", in: self.animation)
                                    .foregroundColor(self.colors[selected])
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 350)

                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.3)) {
                                        self.selected = nil
                                    }
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .foregroundColor(.white)
                                }
                                .frame(width: 25, height: 25)
                                .padding()
                            }
                        }
                        ForEach(0..<30) { _ in
                            Text("A line of text")
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                        }
                        Spacer()
                    }
                    .background(Color.white)
                    .animation(nil)
                }
                .zIndex(100)
                .matchedGeometryEffect(id: "card\(selected)", in: self.animationContainer)
                .ignoresSafeArea()
            }
        }
    }
}

struct MatchFrameInGrid_Previews: PreviewProvider {
    static var previews: some View {
        MatchFrameInGrid()
    }
}
