//
//  ScrollViewWithDetail.swift
//  SwiftUI3D
//
//  Created by Thibault Wittemberg on 2020-05-02.
//  Copyright © 2020 Spinners. All rights reserved.
//

import SwiftUI

let screen = UIScreen.main.bounds

struct Cast: Identifiable {
    let id = UUID()
    let photo: String
    let name: String
}

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let tags: [String]
    let rating: Int
    let director: String
    let overview: String
    let release: String
    let cast: [Cast]
    let classification: String
    let length: String
}

struct ScrollViewWithDetail: View {

    let movies = [
        Movie(title: "Avatar", image: "avatar", tags: ["Aventure", "SciFi"], rating: 74, director: "James Cameron", overview: "In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.", release: "2009", cast: [Cast(photo: "worthington", name: "Sam Worthington"), Cast(photo: "saldana", name: "Zoe Saldana"), Cast(photo: "lang", name: "Stephen Lang"), Cast(photo: "weaver", name: "Sigourney Weaver")], classification: "PG-13", length: "2h 42m"),
        Movie(title: "Predator", image: "predator", tags: ["Action", "Thriller"], rating: 69, director: "John McTiernan", overview: "Dutch and his group of commandos are hired by the CIA to rescue downed airmen from guerillas in a Central American jungle. The mission goes well but as they return they find that something is hunting them. Nearly invisible, it blends in with the forest, taking trophies from the bodies of its victims as it goes along. Occasionally seeing through its eyes, the audience sees it is an intelligent alien hunter, hunting them for sport, killing them off one at a time.", release: "1987", cast: [Cast(photo: "schwarzenegger", name: "Arnold Schwarzenegger"), Cast(photo: "weathers", name: "Carl Weathers"), Cast(photo: "duke", name: "Bill Duke")], classification: "R", length: "1h 47m"),
        Movie(title: "Stargate", image: "stargate", tags: ["SciFi", "Action"], rating: 55, director: "Roland Emmerich", overview: "An interstellar teleportation device, found in Egypt, leads to a planet with humans resembling ancient Egyptians who worship the god Ra.", release: "1994", cast: [Cast(photo: "russell", name: "Kurt Russell"), Cast(photo: "spader", name: "James Spader"), Cast(photo: "avital", name: "Mili Avital")], classification: "PG-13", length: "2h 1m"),
        Movie(title: "Startrek: First contact", image: "startrek", tags: ["SciFi", "Action"], rating: 72, director: "Jonathan Frakes", overview: "The Borg, a relentless race of cyborgs, are on a direct course for Earth. Violating orders to stay away from the battle, Captain Picard and the crew of the newly-commissioned USS Enterprise E pursue the Borg back in time to prevent the invaders from changing Federation history and assimilating the galaxy.", release: "1996", cast: [Cast(photo: "stewart", name: "Patrick Stewart"), Cast(photo: "frakes", name: "Jonathan Frakes"), Cast(photo: "sirtis", name: "Marina Sirtis")], classification: "PG-13", length: "1h 51m"),
        Movie(title: "Starwars: A new hope", image: "starwars", tags: ["Aventure", "SciFi"], rating: 82, director: "George Lucas", overview: "Princess Leia is captured and held hostage by the evil Imperial forces in their effort to take over the galactic Empire. Venturesome Luke Skywalker and dashing captain Han Solo team together with the loveable robot duo R2-D2 and C-3PO to rescue the beautiful princess and restore peace and justice in the Empire.", release: "1977", cast: [Cast(photo: "hamill", name: "Mark Hamill"), Cast(photo: "ford", name: "Harrison Ford"), Cast(photo: "fisher", name: "Carrie Fisher"), Cast(photo: "cushing", name: "Peter Cushing"), Cast(photo: "guinness", name: "Alec Guinness")], classification: "PG", length: "2h 1m"),
        Movie(title: "Avangers: End game", image: "avengers", tags: ["Action", "SciFi"], rating: 83, director: "Russo's brothers", overview: "After the devastating events of Avengers: Infinity War, the universe is in ruins due to the efforts of the Mad Titan, Thanos. With the help of remaining allies, the Avengers must assemble once more in order to undo Thanos' actions and restore order to the universe once and for all, no matter what consequences may be in store.", release: "2019", cast: [Cast(photo: "downey", name: "Robert Downey Jr."), Cast(photo: "evans", name: "Chris Evans"), Cast(photo: "hemsworth", name: "Chris Hemsworth")], classification: "PG-13", length: "3h 1m"),
        Movie(title: "2001: A space odyssey", image: "2001", tags: ["Mystery", "SciFi"], rating: 81, director: "Stanley Kubrick", overview: "Humanity finds a mysterious object buried beneath the lunar surface and sets off to find its origins with the help of HAL 9000, the world's most advanced super computer.", release: "1968", cast: [Cast(photo: "dullea", name: "Keir Dullea"), Cast(photo: "lockwood", name: "Gary Lockwood")], classification: "G", length: "2h 29m")]

    let backgroundColor = Color(red: 230 / 255, green: 230 / 255, blue: 230 / 255)

    @State
    var activeIndex = -1

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                ForEach(self.movies.indices, id: \.self) { index in
                    CardView(index: index, movie: self.movies[index], isSelected: self.isSelected(index: index), activeIndex: self.$activeIndex)
                        .hide(when: self.isNotSelected(index: index) )
                        .offsetToTopLeft(when: self.isSelected(index: index) )
                        .frame(width: self.isSelected(index: index) ? screen.width : 300, height: self.isSelected(index: index) ? screen.height : 300)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                                self.activeIndex.toggleToIndex(index: index)
                            }
                    }
                }
            }
            .frame(width: screen.width)
            .padding(.top, 80)
            .padding(.bottom, 40)
        }
        .background(self.activeIndex == -1 ? self.backgroundColor: Color.black.opacity(0.8))
        .edgesIgnoringSafeArea(.all)

    }

    func isSelected(index: Int) -> Bool {
        index == self.activeIndex
    }

    func isNotSelected(index: Int) -> Bool {
        index != self.activeIndex && self.activeIndex != -1
    }
}

struct CardView: View {

    let index: Int
    let movie: Movie
    let isSelected: Bool

    @Binding
    var activeIndex: Int

    @State
    var dragAmount = CGSize.zero

    var body: some View {

        ZStack(alignment: .top) {
            VStack(spacing: 0) {

                Rectangle()
                    .frame(height: self.isSelected ? 200: 300)
                    .foregroundColor(.clear)

                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(self.movie.title).foregroundColor(.black).font(.title).fontWeight(.heavy)
                                HStack {
                                    Text(self.movie.release).foregroundColor(.gray).font(.caption).fontWeight(.regular)
                                    Text(self.movie.classification).foregroundColor(.gray).font(.caption).fontWeight(.regular)
                                    Text(self.movie.length).foregroundColor(.gray).font(.caption).fontWeight(.regular)
                                }
                            }
                            Spacer()
                            Image(systemName: "heart.circle.fill")
                                .resizable()
                                .foregroundColor(.pink)
                                .frame(width: 40, height: 40)
                        }
                        .padding(.bottom, 10)
                        HStack {
                            ForEach(self.movie.tags, id: \.self) { tag in
                                TagView(tag: tag, strokeColor: .gray, textColor: .black)
                            }
                        }
                        .padding(.bottom, 30)

                        VStack(alignment: .leading) {
                            Text("Plot Summary").foregroundColor(.black).font(.headline).fontWeight(.regular).padding(.bottom, 10)
                            Text(self.movie.overview).foregroundColor(.gray).font(.caption).fontWeight(.regular)
                        }
                        .padding(.bottom, 30)

                        VStack(alignment: .leading) {
                            Text("Director").foregroundColor(.black).font(.headline).fontWeight(.regular).padding(.bottom, 10)
                            Text(self.movie.director).foregroundColor(.gray).font(.caption).fontWeight(.regular)
                        }
                        .padding(.bottom, 30)

                        VStack(alignment: .leading) {
                            Text("Cast").foregroundColor(.black).font(.headline).fontWeight(.regular).padding(.bottom, 10)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(self.movie.cast) { cast in
                                        VStack(alignment: .center) {
                                            Image(cast.photo).resizable().frame(width: 70, height: 70).clipShape(Circle())
                                            Text(cast.name).multilineTextAlignment(.center).font(.caption).foregroundColor(.gray)
                                        }.frame(width: 90)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: self.isSelected ? (screen.height - 200) : 0)
                .background(Color.white)
                .offset(x: self.isSelected ? 0 : -20, y: self.isSelected ? 0 : -20)
                .opacity(self.isSelected ? 1 : 0)
            }

            ZStack(alignment: .top) {
                Rectangle()
                    .foregroundColor(.clear)
                    .parallaxBackground(image: self.movie.image)
                    .overlay(
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.4), .clear, Color.black.opacity(0.4)]),
                                                       startPoint: .top,
                                                       endPoint: .bottom))
                )
                    .overlay(
                        Text(self.movie.title)
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .frame(maxWidth: self.isSelected ? .infinity : 200, alignment: .leading)
                            .opacity(self.isSelected ? 0.0 : 1.0)
                            .padding(),
                        alignment: self.isSelected ? .bottomLeading : .topLeading
                )
                    .overlay(
                        HStack {
                            ForEach(self.movie.tags, id: \.self) { tag in
                                TagView(tag: tag, strokeColor: .white, textColor: .white)
                            }
                        }.opacity(self.isSelected ? 0.0 : 1.0),
                        alignment: .bottomTrailing
                )
                    .overlay(
                        RatingView(rating: self.movie.rating, isSelected: self.isSelected)
                            .frame(width: self.isSelected ? 70 : 50, height: self.isSelected ? 70 : 50)
                            .padding(),
                        alignment: self.isSelected ? .bottomLeading : .topTrailing
                )
                    .clipShape(RoundedRectangle(cornerRadius: self.isSelected ? 0 : 20, style: .continuous))
                    .shadow(color: Color.black.opacity(0.8), radius: self.isSelected ? 2 : 10, x: 0, y: 0)

                if self.isSelected {
                    Rectangle()
                        .foregroundColor(Color.white.opacity(0.1))
                        .gesture(
                            DragGesture().onChanged { (value) in
                                guard value.translation.height > 0 else { return }
                                self.dragAmount = value.translation
                            }
                            .onEnded { value in
                                if value.translation.height > 80 {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                                        self.activeIndex.toggleToIndex(index: self.index)
                                        self.dragAmount = .zero
                                    }
                                } else {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.3, blendDuration: 0)) {
                                        self.dragAmount = .zero
                                    }
                                }
                            }
                    )
                }
            }
            .frame(height: self.isSelected ? 200 : 300)
        }
        .scaleEffect(!self.isSelected ? 1 : 1-(dragAmount.height / 500))
    }
}

struct ScrollViewWithDetail_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewWithDetail()
    }
}

struct TagView: View {

    let tag: String
    let strokeColor: Color
    let textColor: Color

    var body: some View {
        Text(tag)
            .font(.caption)
            .padding(10)
            .foregroundColor(textColor)
            .overlay(RoundedRectangle(cornerRadius: 20, style: .circular).stroke(lineWidth: 2).foregroundColor(strokeColor))
            .padding(.bottom, 15)
            .padding(.trailing, 15)
    }
}

struct RatingView: View {

    let rating: Int
    let isSelected: Bool

    @State
    var actualRating: CGFloat = 0

    var color: Color {
        switch rating {
        case 0..<60:
            return .red
        case 60..<70:
            return .orange
        case 70..<80:
            return .yellow
        default:
            return .green
        }
    }

    var body: some View {
        Circle()
            .foregroundColor(Color.black.opacity(0.5))
            .overlay(
                Circle()
                    .trim(from: 0, to: self.actualRating/100)
                    .stroke(lineWidth: self.isSelected ? 5 : 3)
                    .foregroundColor(self.color)
                    .overlay(Text("\(Int(rating))%").font(.caption).foregroundColor(.white))
                    .onAppear {
                        withAnimation(Animation.spring(response: 0.6, dampingFraction: 0.4, blendDuration: 0).delay(1.3)) {
                            self.actualRating = CGFloat(self.rating)
                        }
            })
    }
}

extension Int {
    mutating func toggleToIndex(index: Int) {
        if self == -1 {
            self = index
        } else {
            self = -1
        }
    }
}

//struct HideModifier: ViewModifier {
//    func body(content: Content) -> some View {
//        content.hidden()
//    }
//}
//
extension View {
    func hide(when predicate: Bool) -> some View {
        self
            .offset(x: predicate ? screen.width : 0)
            .opacity(predicate ? 0 : 1)
    }
}

extension View {
    func offsetToTopLeft(when predicate: Bool) -> some View {
        GeometryReader { proxy in
            self.offset(x: predicate ? -proxy.frame(in: .global).minX : 0, y: predicate ? -proxy.frame(in: .global).minY : 0)
        }
    }
}

extension View {
    func parallaxBackground(image: String) -> some View {
        GeometryReader { proxy in
            self.background(
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(1.2)
                    .offset(y: -proxy.frame(in: .global).minY / 20)
            )
        }
    }
}

//
//extension View {
//    // If condition is met, apply modifier, otherwise, leave the view untouched
//    public func conditionalModifier<T>(_ condition: Bool, _ modifier: T) -> some View where T: ViewModifier {
//        Group {
//            if condition {
//                self.modifier(modifier)
//            } else {
//                self
//            }
//        }
//    }
//}
