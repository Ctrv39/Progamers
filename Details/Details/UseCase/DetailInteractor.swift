//
//  DetailInteractor.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import Foundation
import RxSwift
import CorePackage


public protocol DetailUseCase {
    func getGameDetail() -> Observable<GameDetail>
    func insertFavorites(game: GameDetail) -> Observable<Bool>
    func checkIsfavorites(id: Int) -> Observable<Bool>
    func removeFavorites(id: Int) -> Observable<Bool>
}

public class DetailInteractor: DetailUseCase {
    private let repository: GameRepositoryProtocol
    private let id: Int

    public required init(repository: GameRepositoryProtocol, id: Int) {
        self.repository = repository
        self.id = id
    }

    public func getGameDetail() -> Observable<GameDetail> {
        return repository.getGameDetail(for: id)
    }

    public func insertFavorites(game: GameDetail) -> Observable<Bool> {
        let gameObj = GameDetailMapper.mapGameDetailToGame(input: game)
        return repository.insertFavorites(game: gameObj)
    }

    public func checkIsfavorites(id: Int) -> Observable<Bool> {
        return repository.checkIsfavorites(id: id)
    }

    public func removeFavorites(id: Int) -> Observable<Bool> {
        return repository.removeFavorites(id: id)
    }
}
