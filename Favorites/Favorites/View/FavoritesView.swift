//
//  FavoritesView.swift
//  ProgamersExpert
//
//  Created by Viktor . on 05/11/21.
//

import Foundation
import SwiftUI
import SkeletonUI
import GameRow

public struct FavoritesView: View {
    @ObservedObject var presenter: FavoritesPresenter
    @AppStorage("isDarkMode") private var isDarkMode = false

    public init(presenter: FavoritesPresenter) {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("White"))]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("White"))]
        self.presenter = presenter
    }

    public var body: some View {
        ZStack {
            Color("DarkBlue").ignoresSafeArea()
            ScrollView {
                LazyVStack {
                      ForEach(presenter.games) {  game in
                        ZStack {
                            if game.isFavorites {
                                self.presenter.linkBuilder(for: game.id) {
                                    GameRow(presenter: presenter.provideUseCase(game: game)).padding(.bottom, 8)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }

                    if presenter.loadingState {
                        ForEach(Range(0...4)) { _ in
                            VStack {
                                Text("").skeleton(with: presenter.loadingState)
                                    .shape(type: .rounded(.radius(5, style: .circular)))
                                    .frame(maxHeight: 300)}
                                .background(Color("LightBlue"))
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.25), radius: 10, x: 7, y: 15)
                                .frame(height: 300, alignment: .leading)
                        }
                    }
                }.padding(.horizontal, 14)

                if presenter.games.count == 0 && !presenter.loadingState {
                    VStack(alignment: .center) {
                             Image("game")
                                .resizable()
                                .frame(width: 140, height: 100, alignment: .top)
                            Text("There's nothing here \n Start adding your favorites now!")
                                .foregroundColor(Color("White"))
                                .bold().font(.system(size: 18)).lineLimit(3).padding(.top, 15)
                                .multilineTextAlignment(.center)
                    }.padding(.horizontal, 20).padding(.top, 80)
                }
            }
        }.navigationBarTitle(Text("Favorites"), displayMode: .inline)
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .onAppear {
            presenter.getAllFavorites()
        }
    }
}
