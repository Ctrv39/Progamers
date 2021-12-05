//
//  File.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import SwiftUI
import SkeletonUI
import SDWebImageSwiftUI

public struct GameRow: View {
    @ObservedObject var presenter: GameRowPresenter
    @State private var showAlert = false
    
    public init(presenter: GameRowPresenter) {
        self.presenter = presenter
    }

    public var body: some View {
        if (presenter.game.isFavorites && presenter.source == "favorites") || presenter.source == "home"{
            VStack {
                WebImage(url: URL(string: presenter.game.image))
                  .resizable()
                  .indicator(.activity)
                  .transition(.fade(duration: 0.5))
                  .scaledToFill()
                  .frame( minWidth: 0,
                          maxWidth: .infinity,
                          minHeight: 187,
                          maxHeight: 187,
                          alignment: .topLeading)
                  .cornerRadius(10)
                  .overlay(RatingOverlay(game: presenter.game), alignment: .bottomTrailing)
                VStack(alignment: .leading, spacing: nil, content: {
                    HStack {
                        ForEach(presenter.game.platforms) { plt in
                            Image(plt.platform.slug).resizable().frame(width: 17, height: 17, alignment: .top)
                        }
                        Spacer()
                        Button(action: {
                            if presenter.game.isFavorites {
                                showAlert = true
                            } else {
                                presenter.insertFavorites(presenter.game)
                            }
                        }, label: {
                            if presenter.game.isFavorites {
                                Image("favorites").resizable()
                                    .frame(width: 18, height: 17, alignment: .top).onAppear {
                                    presenter.checkIsFavorites(presenter.game.id)
                                }
                            } else {
                                Image("favorites-outline").resizable()
                                    .frame(width: 18, height: 17, alignment: .top).onAppear {
                                    presenter.checkIsFavorites(presenter.game.id)
                                }
                            }
                        }).alert(isPresented: $showAlert) {
                            Alert(title: Text("Remove from Favorites"),
                                  message: Text("Are you sure?"),
                                  primaryButton: .default(Text("Cancel")),
                                  secondaryButton: .destructive(Text("Sure")) {
                                        presenter.removeFavorites(presenter.game.id)
                                  })
                        }
                    }.padding(.horizontal, 16)
                    Text(presenter.game.name)
                        .bold()
                        .font(.system(size: 20))
                        .padding(.horizontal, 16)
                        .lineLimit(2)
                        .foregroundColor(Color("White"))
                        .skeleton(with: presenter.game.name.isEmpty)
                    HStack {
                        HStack {
                            ForEach(presenter.game.genres) { genre in
                                Text(genre.name)
                                    .font(.system(size: 11))
                                    .padding(4)
                                    .background(Color("DarkBlue"))
                                    .foregroundColor(Color("White"))
                                    .cornerRadius(5)
                            }
                        }
                        Spacer()
                        Image("calendar").resizable().frame(width: 17, height: 17, alignment: .top)
                        Text(getReleaseDate(date: presenter.game.releaseDate))
                            .font(.system(size: 12)).foregroundColor(Color("White"))
                    }.padding(16)
                })
            }.background(Color("LightBlue"))
                .cornerRadius(10).shadow(color: .black.opacity(0.25), radius: 10, x: 7, y: 15)
        }
    }

    private func getReleaseDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd / MM / yy"
        return dateFormatter.string(from: date)
    }
}
