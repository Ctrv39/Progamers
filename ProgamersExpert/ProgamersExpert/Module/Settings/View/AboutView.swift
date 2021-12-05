//
//  File.swift
//  ProgamersExpert
//
//  Created by Viktor . on 05/11/21.
//

import Foundation
import SwiftUI

struct AboutView: View {
    @Binding var isPresented: Bool
    @AppStorage("isDarkMode") private var isDarkMode = false

    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("Black"))]
        UINavigationBar.appearance().backgroundColor = UIColor(Color("DarkBlue"))
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color("DarkBlue").ignoresSafeArea()
                    VStack {
                        Spacer(minLength: 20)
                        Image("profile").resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125, alignment: .center)
                            .clipShape(Circle())
                        Text("Viktor").foregroundColor(Color("White")).font(.system(size: 36)).bold()
                        Text("Mobile Developer")
                            .foregroundColor(Color("LightBlue"))
                            .font(.system(size: 16))
                            .padding(.bottom, 50)
                        Text("Reach Me At")
                            .foregroundColor(Color("White"))
                            .font(.system(size: 16))
                            .bold()
                            .padding(.bottom, 10)
                        Text("lee.viktor96@gmail.com")
                            .foregroundColor(Color("White"))
                            .font(.system(size: 18))
                            .padding(.bottom, 5)
                        Text("0851 5509 8040").foregroundColor(Color("White")).font(.system(size: 18))
                        Spacer(minLength: 60)
                    }
            }.navigationBarTitle("About", displayMode: .inline)
            .navigationBarItems( trailing: Button("Close") {
                self.isPresented = false
            })
        }.environment(\.colorScheme, isDarkMode ? .dark :.light)
    }
}
