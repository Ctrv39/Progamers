//
//  ContentView.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import SwiftUI

struct ContentView: View {
    var homePresenter = HomePresenter(homeUseCase: Injection.init().provideHome())
    var body: some View {
        NavigationView {
            HomeView(presenter: homePresenter)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
