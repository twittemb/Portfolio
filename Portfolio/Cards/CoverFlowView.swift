////
////  CoverFlowView.swift
////  SwiftUI3D
////
////  Created by Thibault Wittemberg on 2020-03-02.
////  Copyright © 2020 Spinners. All rights reserved.
////
//
import SwiftUI

let models = [
    CardModel(name: "Avatar",
              image: "avatar",
              stars: 4,
              categories: ["Sci-Fi", "Action", "Ecologist"],
              plot: "A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home."),
    CardModel(name: "Star Wars",
              image: "starwars",
              stars: 3,
              categories: ["Sci-Fi", "Space Opera", "Drama"],
              plot: "Following a threat of revenge by the revived Emperor Palpatine, Kylo Ren obtains a Sith wayfinder, leading him to the uncharted planet Exegol."),
    CardModel(name: "Star Trek",
              image: "startrek",
              stars: 5,
              categories: ["Sci-Fi", "Space Opera", "Action"],
              plot: "Following the Borg sphere, Picard and his crew realize that they have taken over the Enterprise in order to carry out their mission."),
    CardModel(name: "Predator",
              image: "predator",
              stars: 4,
              categories: ["Sci-Fi", "Action", "War"],
              plot: "A team of commandos on a mission in a Central American jungle find themselves hunted by an extraterrestrial warrior."),
    CardModel(name: "Stargate",
              image: "stargate",
              stars: 2,
              categories: ["Sci-Fi", "Action", "Crap"],
              plot: "An interstellar teleportation device, found in Egypt, leads to a planet with humans resembling ancient Egyptians who worship the god Ra.")

]

struct CoverFlowView<CardableType: Cardable & View>: View {
    let models: [CardableType.CardModelType]

    init(cardModels: [CardableType.CardModelType]) {
        self.models = cardModels
    }

    var body: some View {
        ZStack {
            GeometryReader { mainGeo in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(self.models.indices) { index in
                            GeometryReader { geo in
                                return CardableType.init(cardModel: self.models[index])
                                    .overlay(Color.black.opacity(geo.frame(in: .global).toOpacity))
                                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                    .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 20)
                                    .scaleEffect(geo.frame(in: .global).toScale)
                                    .rotationEffect(.degrees(geo.frame(in: .global).toRotation), anchor: .bottomTrailing)
                                    .shadow(radius: 30)

                            }
                            .frame(width: mainGeo.size.width - 80, height: 500)
                            .modifier(CustomScrollViewPadding(totalItems: self.models.count, currentItem: index))

                        }
                        .frame(height: mainGeo.size.height)
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .top, endPoint: .bottomTrailing))
            }
        }
    }
}

fileprivate extension CGRect {
    var toOpacity: Double {
        abs(Double(((self.minX-40) / 1000)))
    }

    var toScale: CGFloat {
        1-abs(CGFloat(((self.minX-40) / 2000)))
    }

    var toRotation: Double {
        Double(self.minX-40) / 64
    }
}

fileprivate struct CustomScrollViewPadding: ViewModifier {

    let totalItems: Int
    let currentItem: Int

    func body(content: Content) -> some View {
        return content
            .padding([.leading], currentItem == 0 ? 40 : 0)
            .padding([.trailing], currentItem == (totalItems - 1) ? 40 : 0)
    }
}

struct CoverFlowView_Previews: PreviewProvider {
    static var previews: some View {
        CoverFlowView<MovieCardView>(cardModels: models)
    }
}

protocol Cardable {
    associatedtype CardModelType

    init(cardModel: CardModelType)
}

struct CardModel {
    let name: String
    let image: String
    let stars: Int
    let categories: [String]
    let plot: String
}

struct MovieCardView: View, Cardable {

    @State
    private var showDetail = false

    private let model: CardModel

    init(cardModel: CardModel) {
        self.model = cardModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(model.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipped()

            HStack {
                Text("Rating: ")
                ForEach(1...self.model.stars, id: \.self) { index in
                    Image(systemName: "star.fill")
                }
                ForEach(self.model.stars..<5, id: \.self) { index in
                    Image(systemName: "star")
                }
                Spacer()
            }
            .padding()
            .accentColor(.yellow)
            .frame(height: 50)
            .background(Color.black)
            .foregroundColor(.yellow)


            HStack(alignment: .center, spacing: 10) {
                ForEach(self.model.categories, id: \.self) { category in
                    Text(category)
                        .font(.caption)
                        .fontWeight(.light)
                        .padding(10)
                        .foregroundColor(.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke()
                                .foregroundColor(.gray)
                    )
                }
            }
            .padding()

            Text(model.name)
                .foregroundColor(.black)
                .font(.largeTitle)
                .bold()
                .padding(.leading)

            Text("Plot Summary")
                .foregroundColor(.black)
                .font(.callout)
                .fontWeight(.bold)
                .padding()

            Text(self.model.plot)
                .foregroundColor(.gray)
                .padding([.leading, .trailing])
                .font(.caption)

            Spacer()
        }

        .frame(maxWidth: self.showDetail ? .infinity : 300, maxHeight: self.showDetail ? .infinity : 480)
        .background(Color.white)
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(cardModel: CardModel(name: "Avatar",
                                      image: "avatar",
                                      stars: 4,
                                      categories: ["Sci-Fi", "Action", "Drama"],
                                      plot: "A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home."))
    }
}
