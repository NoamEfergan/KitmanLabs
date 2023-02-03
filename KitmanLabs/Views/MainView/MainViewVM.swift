//
//  MainViewVM.swift
//  KitmanLabs
//
//  Created by Noam Efergan on 03/02/2023.
//

import Foundation
import OrderedCollections

final class MainViewVM: ObservableObject {
    typealias PresentableData = OrderedDictionary <Squad, [Athlete]>
    private let networkService = NetworkService()
    @Published var isLoading: Bool = false
    @Published var hasError: Bool = false
    @Published var presentableData: PresentableData = [:]
    
    @MainActor
    func getContent() async {
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            hasError = false
            let squads = try await networkService.perform(path: "/squads", responseType: [Squad].self, requestType: .GET)
            let athletes = try await networkService.perform(path: "/athletes", responseType: [Athlete].self, requestType: .GET)
            presentableData = matchAthletesWithSquads(athletes, squads)
        } catch {
            print("Failed to load squads and athletes with error: \(error.localizedDescription)")
            hasError = true
        }
    }
    
    private func matchAthletesWithSquads(_ athletes: [Athlete], _ squads: [Squad]) -> PresentableData {
        var result: PresentableData = [:]
        for squad in squads {
            result[squad] = athletes.filter { $0.squadIDS.contains(squad.id) }
        }
        result = result.filter { !$0.value.isEmpty}
        return result
    }
}
