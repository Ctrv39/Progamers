//
//  SettingsView.swift
//  ProgamersExpert
//
//  Created by Viktor . on 01/11/21.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) var colorScheme

    @AppStorage("isDarkMode") private var isDarkMode = false

    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("Black"))]
        UINavigationBar.appearance().backgroundColor = UIColor(Color("DarkBlue"))
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor(Color("DarkBlue"))
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color("DarkBlue").ignoresSafeArea()
                List {
                    Section(header: Text("Appearance")) {
                        Toggle(isOn: $isDarkMode, label: {
                            Text("Dark Mode").foregroundColor(Color("White"))
                        }).listRowBackground(Color("DarkBlue"))
                    }
                }.listStyle(GroupedListStyle()).padding(.top, 10)
            }.navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing: Button("Close") {
                self.isPresented = false
            })
        }.environment(\.colorScheme, isDarkMode ? .dark :.light)
    }
}
