//
//  Injection.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import Foundation
import CorePackage
import GameRow
import Details
import Favorites

final class Injection: NSObject {

    private func provideRepository() -> GameRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance

        return GameRepository.sharedInstance(remote, locale)
    }

    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }

    func provideDetail(id: Int) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, id: id)
    }

    func provideGameRow() -> GameRowUseCase {
        let repository = provideRepository()
        return GameRowInteractor(repository: repository)
    }

    func provideFavorites() -> FavoritesUseCase {
        let repository = provideRepository()
        return FavoritesInteractor(repository: repository)
    }

}
