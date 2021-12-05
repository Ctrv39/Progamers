//
//  HomeRouter.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import SwiftUI
import Favorites
import Details

class HomeRouter {
    func makeDetailView(for id: Int) -> some View {
        let detailUseCase = Injection.init().provideDetail(id: id)
        let presenter = GameDetailPresenter(detailUseCase: detailUseCase)
        return GameDetailView(presenter: presenter)
    }

    func makeFavoritesView() -> some View {
        let favoritesUseCase = Injections.init().provideFavorites()
        let presenter = FavoritesPresenter(favoritesUseCase: favoritesUseCase)
        return FavoritesView(presenter: presenter)
    }
}
