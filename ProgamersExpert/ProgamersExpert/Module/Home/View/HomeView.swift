import SwiftUI
import SkeletonUI
import AlertToast
import GameRow

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    @State private var showingActionSheet = false
    @State private var showSettingsModal = false
    @State private var showAboutModal = false
    @State private var showToast = false
    @AppStorage("isDarkMode") private var isDarkMode = false

    init(presenter: HomePresenter) {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("White"))]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("White"))]
        self.presenter = presenter
    }

    var body: some View {
        ZStack {
            Color("DarkBlue").ignoresSafeArea()
            ScrollView {
                LazyVStack {
                    ForEach(Array(presenter.games.enumerated()), id: \.offset) { index, game in
                        ZStack {
                            self.presenter.linkBuilder(for: game.id) {
                                GameRow(presenter: presenter.provideUseCase(game: game))
                                    .padding(.bottom, 8).onAppear(perform: {
                                    if index == presenter.games.count-1 && !presenter.endOfPage {
                                        presenter.getGameList()
                                    }
                                })
                            }.buttonStyle(PlainButtonStyle())
                        }.onAppear {
                        }
                    }
                    if presenter.loadingState {
                        ForEach(Range(0...4)) { _ in
                            VStack {
                                Text("").skeleton(with: presenter.loadingState)
                                    .shape(type: .rounded(.radius(5, style: .circular)))
                                .frame(maxHeight: 300)}
                            .background(Color("LightBlue"))
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.25), radius: 10, x: 7, y: 15)
                            .frame(height: 300, alignment: .leading)
                        }
                    }
                }.padding(.horizontal, 14)
            }
        }
        .navigationTitle("Games")
        .navigationBarItems(leading: Image("more")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .top)
                                .onTapGesture {
            self.showingActionSheet = true
        }, trailing: self.presenter.linkBuilderFavorites {
            Image("favorites-outline-blue")
                .resizable()
                .frame(width: 20, height: 20, alignment: .top)
        })
        .actionSheet(isPresented: $showingActionSheet, content: actionSheet)
        .sheet(isPresented: $showSettingsModal, content: {
            SettingsView(isPresented: $showSettingsModal)
        })
        .sheet(isPresented: $showAboutModal, content: {
            AboutView(isPresented: $showAboutModal)
        }
        ).onAppear {
            presenter.getGameList()
        }.preferredColorScheme(isDarkMode ? .dark : .light)
            .toast(isPresenting: $showToast) {
                AlertToast(type: .error(Color.red), title: "Something went Wrong!")
            }
    }

    private func actionSheet() -> ActionSheet {
        return ActionSheet(title: Text("More"), buttons: [
            .default(Text("Settings")) {
                showSettingsModal = true
            },
            .default(Text("About")) {
                showAboutModal = true
            },
            .cancel()
        ])
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12").preferredColorScheme(.dark)
    }
}
