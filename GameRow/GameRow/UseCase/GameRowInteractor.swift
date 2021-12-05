//
//  GameRowInteractor.swift
//  ProgamersExpert
//
//  Created by Viktor . on 02/11/21.
//

import Foundation
import RxSwift
import CorePackage

public protocol GameRowUseCase {
    func insertFavorites(game: Game) -> Observable<Bool>
    func checkIsfavorites(id: Int) -> Observable<Bool>
    func removeFavorites(id: Int) -> Observable<Bool>
}

public class GameRowInteractor: GameRowUseCase {
    public let repository: GameRepositoryProtocol

    public required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }

    public func insertFavorites(game: Game) -> Observable<Bool> {
        return repository.insertFavorites(game: game)
    }

    public func checkIsfavorites(id: Int) -> Observable<Bool> {
        return repository.checkIsfavorites(id: id)
    }

    public func removeFavorites(id: Int) -> Observable<Bool> {
        return repository.removeFavorites(id: id)
    }

}
