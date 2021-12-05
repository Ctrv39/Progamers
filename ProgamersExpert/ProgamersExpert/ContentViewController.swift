//
//  ContentViewController.swift
//  ProgamersExpert
//
//  Created by Viktor . on 01/11/21.
//

import Foundation

class ContentViewController: ObservableObject {
    func initializeData() {
        let homeUseCase = Injection.init().provideHome()
        let homePresenter = HomePresenter(homeUseCase: homeUseCase)
        let contentView = ContentView()
            .environmentObject(homePresenter)
    }
}
