//
//  FavoritesInteractor.swift
//  ProgamersExpert
//
//  Created by Viktor . on 05/11/21.
//

import Foundation
import RxSwift
import CorePackage

public protocol FavoritesUseCase {
    func getAllFavorites() -> Observable<[Game]>
    func checkIsfavorites(id: Int) -> Observable<Bool>
}

public class FavoritesInteractor: FavoritesUseCase {
    private let repository: GameRepositoryProtocol

    public required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }

    public func getAllFavorites() -> Observable<[Game]> {
        return repository.getAllFavorites()
    }

    public func checkIsfavorites(id: Int) -> Observable<Bool> {
        return repository.checkIsfavorites(id: id)
    }

}
