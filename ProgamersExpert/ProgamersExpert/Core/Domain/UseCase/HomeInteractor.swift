//
//  HomeInteractor.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import Foundation
import RxSwift
import CorePackage

protocol HomeUseCase {
    var isGetGameCalled: Bool { get set }
    func getGameList(page: Int) -> Observable<GameList>
}

class HomeInteractor: HomeUseCase {
    private let repository: GameRepositoryProtocol
    var isGetGameCalled: Bool = false
    required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }

    func getGameList(page: Int) -> Observable<GameList> {
        return repository.getGameList(page: page)
    }
}
