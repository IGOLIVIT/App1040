//
//  GoalsViewModel.swift
//  App1040
//
//  Created by IGOR on 08/11/2024.
//

import SwiftUI
import CoreData

final class GoalsViewModel: ObservableObject {

    @Published var isAdd: Bool = false
    @Published var isDetail: Bool = false
    @Published var isDelete: Bool = false
    
    @Published var photos: [String] = ["s1", "s2"]
    @Published var currentPhoto = ""
    
    @Published var gPhoto: String = ""
    @Published var gTitle: String = ""
    @Published var gDate: String = ""
    @Published var gName: String = ""

    @Published var goals: [GoalModel] = []
    @Published var selectedGoal: GoalModel?

    func addGoal() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "GoalModel", into: context) as! GoalModel

        loan.gPhoto = gPhoto
        loan.gTitle = gTitle
        loan.gDate = gDate
        loan.gName = gName

        CoreDataStack.shared.saveContext()
    }

    func fetchGoals() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<GoalModel>(entityName: "GoalModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.goals = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.goals = []
        }
    }
}
