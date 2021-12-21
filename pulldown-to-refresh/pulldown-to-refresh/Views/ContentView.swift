//
//  ContentView.swift
//  pulldown-to-refresh
//
//  Created by Sachin Daingade on 21/12/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var listViewModel = ListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(listViewModel.users) { user in
                            Text("\(user.name)")
                        }
                    }.addRefreshableView {
                        DispatchQueue.main.async {
                            listViewModel.input = .getAllUser
                        }
                    }
                }
            }
        }
        .navigationTitle("Refreshable List")
        .onAppear {
            listViewModel.input = .getAllUser
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
