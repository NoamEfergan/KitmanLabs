//
//  MainView.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var vm = MainViewVM()
    var body: some View {
        Group {
            List {
                ForEach(vm.presentableData.keys, id: \.id) { squad in
                    Section(squad.name) {
                        ForEach(vm.presentableData[squad] ?? [], id: \.self) { athlete in
                            AthleteView(athlete: athlete)
                        }
                    }
                }
            }
        }
        .loadingOverlay(isShowing: $vm.isLoading, text: "Fetching data...")
        .task {
            await vm.getContent()
        }
        .alert("Whoops!\nsomething went wrong",
               isPresented: $vm.hasError) {
            Button {
                vm.hasError = false
            } label: {
                Text("Please try again later")
            }
        }
        .navigationTitle("Hello, \(UserDefaults.userName)!")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainView()
                .environmentObject(NavigationService())
        }
    }
}
