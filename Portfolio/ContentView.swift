//
//  ContentView.swift
//  Portfolio
//
//  Created by Thibault Wittemberg on 2020-11-01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Matched Geometry Effect")) {
                    NavigationLink("Match positions", destination: MatchPositionsView())
                    NavigationLink("Match size", destination: MatchSizesView())
                    NavigationLink("Match positions with fly effect", destination: MatchPositionsAndFly())
                    NavigationLink("Match frames in Grid", destination: MatchFrameInGrid())
                }

                Section(header: Text("Animations")) {
                    NavigationLink("Animatable modifier", destination: AnimatableModifierView())
                    NavigationLink("Flip card with AnimatableShape", destination: FlipCardRotationView())
                    NavigationLink("Flip card with GeometryEffect", destination: FlipCardGeometryEffectView())
                    NavigationLink("Animated Graph", destination: AnimatableGraphView())
                    NavigationLink("Drag 3D", destination: DragView())
                }

                Section(header: Text("Cards")) {
                    NavigationLink("Scrollview with detail", destination: ScrollViewWithDetail())
                    NavigationLink("CoverFlow like", destination: CoverFlowView<MovieCardView>(cardModels: models))
                }
            }.navigationTitle("Portfolio")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
