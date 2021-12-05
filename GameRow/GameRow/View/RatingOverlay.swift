//
//  RatingOverlay.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import SwiftUI
import CorePackage

struct RatingOverlay: View {

    var game: Game
    var body: some View {
        HStack(alignment: .bottom) {
            Text(String(game.rating))
                .font(.system(size: 22))
                .foregroundColor(getRatingColor())
                .bold()
                .padding(.trailing, -7).padding(.bottom, -4)
            Text("/ \(game.maxRating)").font(.system(size: 12)).foregroundColor(Color.white).bold()
        }.padding([.trailing, .bottom], 8)
    }

    private func getRatingColor() -> Color {
        switch game.rating {
        case 4.0...:
            return Color("Green")
        case 2.5..<4.0:
            return Color("Yellow")
        default:
            return Color("Red")

        }
    }
}
