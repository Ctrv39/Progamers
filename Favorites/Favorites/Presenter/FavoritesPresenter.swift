//
//  FavoritesPresenter.swift
//  ProgamersExpert
//
//  Created by Viktor . on 05/11/21.
//

import SwiftUI
import RxSwift
import CorePackage
import GameRow

public class FavoritesPresenter: ObservableObject {
    private let router = FavoritesRouter()

    private let disposeBag = DisposeBag()
    private let favoritesUseCase: FavoritesUseCase

    @Published var loadingState = false
    @Published var games: [Game] = []

    public init(favoritesUseCase: FavoritesUseCase) {
        self.favoritesUseCase = favoritesUseCase
    }

    public func getAllFavorites() {
        loadingState = true
        favoritesUseCase.getAllFavorites()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.games = result
            } onError: { error in
                print(error)
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }

    func checkIsFavorites(index: Int) {
        favoritesUseCase.checkIsfavorites(id: games[index].id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.games[index].isFavorites = result
            }onError: { _ in
                self.games[index].isFavorites = false
            }
            .disposed(by: disposeBag)
    }

    func linkBuilder<Content: View> (
        for id: Int,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: id)) { content() }
    }

    func provideUseCase(game: Game) -> GameRowPresenter {
        return GameRowPresenter(gameRowUseCase: Injections.init().provideGameRow(), game: game, source: "favorites")
    }
}
