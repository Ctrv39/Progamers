//
//  DetailPresenter.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import SwiftUI
import RxSwift
import CorePackage

public class GameDetailPresenter: ObservableObject {
    @Published var gameDetail: GameDetail = GameDetail.getDummyData()
    @Published var loadingState = false
    private let disposeBag = DisposeBag()
    private let detailUseCase: DetailUseCase

    public init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        self.getGameDetail()
    }

    func getGameDetail() {
        loadingState = true
        detailUseCase.getGameDetail().observe(on: MainScheduler.instance).subscribe { result in
            self.gameDetail = result
            self.checkIsFavorites(self.gameDetail.itemId)
        } onError: { error in
            print(error)
        } onCompleted: {
            self.loadingState = false
        }.disposed(by: disposeBag)
    }

    func insertFavorites(_ game: GameDetail) {
        detailUseCase.insertFavorites(game: game)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.gameDetail.isFavorites = result
            } onError: { _ in
                self.gameDetail.isFavorites = false
            }
            .disposed(by: disposeBag)
    }

    func removeFavorites(_ id: Int) {
        detailUseCase.removeFavorites(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { _ in
                self.gameDetail.isFavorites = false
            } onError: { _ in
                self.gameDetail.isFavorites = true
            }
            .disposed(by: disposeBag)
    }

    func checkIsFavorites(_ id: Int) {
        detailUseCase.checkIsfavorites(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.gameDetail.isFavorites = result
            }
            .disposed(by: disposeBag)
    }
}
