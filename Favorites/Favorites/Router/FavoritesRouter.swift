//
//  FavoritesRouter.swift
//  ProgamersExpert
//
//  Created by Viktor . on 05/11/21.
//

import SwiftUI
import CorePackage
import GameRow
import Details

class FavoritesRouter {
    func makeDetailView(for id: Int) -> some View {
        let detailUseCase = Injections.init().provideDetail(id: id)
        let presenter = GameDetailPresenter(detailUseCase: detailUseCase)
        return GameDetailView(presenter: presenter)
    }
}


public final class Injections: NSObject {

    private func provideRepository() -> GameRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance

        return GameRepository.sharedInstance(remote, locale)
    }


    func provideDetail(id: Int) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, id: id)
    }

    public func provideGameRow() -> GameRowUseCase {
        let repository = provideRepository()
        return GameRowInteractor(repository: repository)
    }

    public func provideFavorites() -> FavoritesUseCase {
        let repository = provideRepository()
        return FavoritesInteractor(repository: repository)
    }

}
