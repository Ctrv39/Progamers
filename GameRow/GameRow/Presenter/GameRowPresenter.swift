//
//  GameRowPresenter.swift
//  ProgamersExpert
//
//  Created by Viktor . on 02/11/21.
//

import Foundation
import RxSwift
import CorePackage


public class GameRowPresenter: ObservableObject {
    @Published var game: Game
    @Published var source: String

    public let gameRowUseCase: GameRowUseCase
    public let disposeBag = DisposeBag()

    public init(gameRowUseCase: GameRowUseCase, game: Game, source: String) {
        self.gameRowUseCase = gameRowUseCase
        self.game = game
        self.source = source
    }

    func insertFavorites(_ game: Game) {
        gameRowUseCase.insertFavorites(game: game)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.game.isFavorites = result
            } onError: { _ in
                self.game.isFavorites = false
            }
            .disposed(by: disposeBag)
    }

    func removeFavorites(_ id: Int) {
        gameRowUseCase.removeFavorites(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                self.game.isFavorites = false
            }
            .disposed(by: disposeBag)
    }

    func checkIsFavorites(_ id: Int) {
        gameRowUseCase.checkIsfavorites(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.game.isFavorites = result
            } onError: { _ in
                self.game.isFavorites = false
            }
            .disposed(by: disposeBag)
    }
}
