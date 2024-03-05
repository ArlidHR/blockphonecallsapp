//
//  CallDirectoryHandler.swift
//  CallDirectory
//
//  Created by Arlid Henao Rueda on 18/02/24.
//

import Foundation
import CallKit
import SwiftData

class CallDirectoryHandler: CXCallDirectoryProvider {
    
    var container: ModelContainer = {
        var fullSchema = Schema([ContactModel.self])
        let modelConfiguration = ModelConfiguration(
            schema: fullSchema,
            groupContainer: .identifier("group.geniusoft.blockcall")
        )
        return try! ModelContainer(for: fullSchema, configurations: [modelConfiguration])
    }()
    
    @MainActor
    func fetchAll() throws -> [ContactModel] {
        let fetchDescriptor = FetchDescriptor<ContactModel>(sortBy: [SortDescriptor<ContactModel>(\.phone)])
        do {
            return try container.mainContext.fetch(fetchDescriptor)
        } catch {
            print("Error \(error)")
            return []
        }
    }

    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        Task {
            let contactModels = try await fetchAll()

            let blockedNumbers: [CXCallDirectoryPhoneNumber] = contactModels.map { contactModel in
                let blockedNumber: CXCallDirectoryPhoneNumber? = Int64(contactModel.phone)
                return blockedNumber
            }.compactMap{ $0 }
            
            for number in blockedNumbers {
                context.addBlockingEntry(withNextSequentialPhoneNumber: number)
            }
            await context.completeRequest()
        }
    }
}
