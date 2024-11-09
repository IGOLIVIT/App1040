//
//  HomeViewModel.swift
//  App1040
//
//  Created by IGOR on 06/11/2024.
//

import SwiftUI
import CoreData

final class HomeViewModel: ObservableObject {

    @Published var distances: [String] = ["50", "100", "200", "400", "800", "1500"]
    @Published var currentDist = "All"
    @Published var distForAdd = ""

    @Published var isAdd: Bool = false
    @Published var isDetail: Bool = false
    @Published var isDelete: Bool = false
    @Published var isAddRecord: Bool = false
    
    @Published var photos: [String] = ["s1", "s2"]
    @Published var currentPhoto = ""

    @Published var phName: String = ""
    @Published var phImage: String = ""

    @Published var images: [PhotoModel] = []

    func addImage() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "PhotoModel", into: context) as! PhotoModel

        loan.phName = phName
        loan.phImage = phImage

        CoreDataStack.shared.saveContext()
    }

    func fetchImages() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PhotoModel>(entityName: "PhotoModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.images = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.images = []
        }
    }
    
    @Published var trSP: String = ""
    @Published var trTime: String = ""
    @Published var trDist: String = ""

    @Published var records: [TrainModel] = []
    @Published var selectedRec: TrainModel?

    func addRec() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "TrainModel", into: context) as! TrainModel

        loan.trSP = trSP
        loan.trTime = trTime
        loan.trDist = trDist

        CoreDataStack.shared.saveContext()
    }

    func fetchRecss() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TrainModel>(entityName: "TrainModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.records = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.records = []
        }
    }
}
