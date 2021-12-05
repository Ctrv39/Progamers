//
//  HomePresenter.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import SwiftUI
import RxSwift
import CorePackage
import GameRow

class HomePresenter: ObservableObject {
    private let router = HomeRouter()
    private let disposeBag = DisposeBag()
    private let homeUseCase: HomeUseCase

    @Published var games: [Game] = []
    @Published var page = 1
    @Published var loadingState = false
    @Published var endOfPage = false
    @Published var showToast = false

    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }

    func getGameList() {
        loadingState = true
        homeUseCase.getGameList(page: self.page)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.games.append(contentsOf: result.results)
                if result.next == "" {
                    self.endOfPage = true
                } else {
                    self.page += 1
                }
            } onError: { _ in
                self.showToast = true
            } onCompleted: {
                self.loadingState = false
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

    func linkBuilderFavorites<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeFavoritesView()) { content() }
    }

    func provideUseCase(game: Game) -> GameRowPresenter {
        return GameRowPresenter(gameRowUseCase: Injection.init().provideGameRow(), game: game, source: "home")
    }
}
