//
//  GameDetailView.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import SwiftUI
import SkeletonUI
import AlertToast
import CorePackage

public struct GameDetailView: View {
    @ObservedObject var presenter: GameDetailPresenter
    @State var showToast = false
    @State var showAlert = false
    public init(presenter: GameDetailPresenter) {
        self.presenter = presenter
    }
    public var body: some View {
        ZStack {
            Color("DarkBlue").ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: nil, content: {
                    if presenter.gameDetail.itemId != -1 {
                        AsyncImage(url: URL(string: presenter.gameDetail.image)!,
                                   placeholder: { Text("Loading ...")},
                                   image: { Image(uiImage: $0).resizable() })
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } else {
                        Text("").skeleton(with: true)
                            .shape(type: .rounded(.radius(5, style: .circular)))
                            .frame(maxHeight: 200)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.25), radius: 10, x: 7, y: 15)
                            .frame(height: 200, alignment: .leading)
                    }
                    Text(presenter.gameDetail.name)
                        .bold()
                        .font(.system(size: 25))
                        .lineLimit(2)
                        .foregroundColor(Color("White"))
                        .padding(.vertical, 10)
                        .skeleton(with: presenter.gameDetail.itemId == -1)
                        .shape(type: .rounded(.radius(5, style: .circular)))
                        .multiline(lines: 2, scales: [1: 0.5])
                    HStack(alignment: .center, spacing: 10, content: {
                        VStack(alignment: .center, spacing: nil, content: {
                            Text("Release Date")
                                .font(.system(size: 15))
                                .foregroundColor(Color("Gray"))
                                .skeleton(with: presenter.gameDetail.itemId == -1)
                                .shape(type: .rounded(.radius(5, style: .circular)))
                            Text(presenter.gameDetail.releaseDate)
                                .font(.system(size: 18))
                                .foregroundColor(Color("White"))
                                .padding(.top, 10)
                                .skeleton(with: presenter.gameDetail.itemId == -1)
                                .shape(type: .rounded(.radius(5, style: .circular)))
                        }).frame(minWidth: 0, maxWidth: .infinity)
                        HStack {
                            Divider()
                        }.frame(height: 90)
                        VStack(alignment: .center, spacing: nil, content: {
                            Text("Ratings")
                                .font(.system(size: 15))
                                .foregroundColor(Color("Gray"))
                                .skeleton(with: presenter.gameDetail.itemId == -1)
                                .shape(type: .rounded(.radius(5, style: .circular)))
                            HStack(alignment: .bottom) {
                                Text(String(presenter.gameDetail.rating))
                                    .font(.system(size: 26))
                                    .foregroundColor(presenter.gameDetail.getRatingColor())
                                    .bold()
                                    .padding(.trailing, -7)
                                    .padding(.bottom, -4)
                                    .skeleton(with: presenter.gameDetail.itemId == -1)
                                    .shape(type: .rounded(.radius(5, style: .circular)))
                                Text("/ \(presenter.gameDetail.maxRating)")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("White"))
                                    .bold()
                                    .skeleton(with: presenter.gameDetail.itemId == -1)
                                    .shape(type: .rounded(.radius(5, style: .circular)))
                            }.padding(.top, 2).frame(minWidth: 0, maxWidth: .infinity)
                        })
                        HStack {
                            Divider()
                        }.frame(height: 90)
                        if let esrb = presenter.gameDetail.esrb {
                            Image(esrb.slug)
                                .resizable()
                                .frame(width: 33, height: 53)
                                .frame(minWidth: 0, maxWidth: 60)
                                .skeleton(with: presenter.gameDetail.itemId == -1)
                                .shape(type: .rounded(.radius(5, style: .circular)))
                        } else {
                            Text("-").font(.system(size: 20)).foregroundColor(Color("Gray"))
                        }
                    }).padding(.bottom, 10)
                    Text("Genres")
                        .font(.system(size: 15))
                        .foregroundColor(Color("Gray"))
                        .skeleton(with: presenter.gameDetail.itemId == -1)
                        .shape(type: .rounded(.radius(5, style: .circular)))
                    HStack {
                        ForEach(presenter.gameDetail.genres) { genre in
                            Text(genre.name)
                                .bold()
                                .font(.system(size: 15))
                                .padding(4)
                                .background(Color("LightBlue"))
                                .foregroundColor(Color("Black"))
                                .cornerRadius(5).skeleton(with: presenter.gameDetail.itemId == -1)
                                .shape(type: .rounded(.radius(5, style: .circular)))
                        }
                    }.padding(.bottom, 20)
                    Text("Available In")
                        .font(.system(size: 15))
                        .foregroundColor(Color("Gray"))
                        .skeleton(with: presenter.gameDetail.itemId == -1)
                        .shape(type: .rounded(.radius(5, style: .circular)))
                    HStack {
                        ForEach(presenter.gameDetail.platforms) { plt in
                            Image(plt.platform.slug)
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .top)
                                .skeleton(with: presenter.gameDetail.itemId == -1)
                                .shape(type: .rounded(.radius(5, style: .circular)))
                        }
                    }.padding(.bottom, 20)
                    Text("About Games")
                        .font(.system(size: 15))
                        .foregroundColor(Color("Gray"))
                        .padding(.bottom, 10)
                        .skeleton(with: presenter.gameDetail.itemId == -1)
                        .shape(type: .rounded(.radius(5, style: .circular)))
                    Text(presenter.gameDetail.description)
                        .font(.system(size: 15))
                        .foregroundColor(Color("White"))
                        .lineSpacing(3)
                        .skeleton(with: presenter.gameDetail.itemId == -1)
                        .shape(type: .rounded(.radius(5, style: .circular)))
                        .multiline(lines: 4)
                })
            }.padding(14)
        }.navigationBarTitle(Text("Details"), displayMode: .automatic)
            .toast(isPresenting: $showToast) {
            AlertToast(type: .error(Color.red), title: "Something went Wrong!")
        }.navigationBarItems(trailing: Image(presenter.gameDetail.isFavorites ? "favorites" : "favorites-outline")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .top).onTapGesture {
                                    if presenter.gameDetail.isFavorites {
                                        showAlert = true
                                    } else {
                                        presenter.insertFavorites(presenter.gameDetail)
                                    }
                                }.skeleton(with: presenter.gameDetail.itemId == -1))
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Remove from Favorites"),
                  message: Text("Are you sure?"),
                  primaryButton: .default(Text("Cancel")),
                  secondaryButton: .destructive(Text("Sure")) {
                presenter.removeFavorites(presenter.gameDetail.itemId)
                  })
        }
    }
}
