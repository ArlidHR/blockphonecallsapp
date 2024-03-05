//
//  blockphonecallsappApp.swift
//  blockphonecallsapp
//
//  Created by Arlid Henao Rueda on 17/02/24.
//

import SwiftUI
import SwiftData

@main
struct blockphonecallsappApp: App {
    var container: ModelContainer = {
        var fullSchema = Schema([ContactModel.self])
        let modelConfiguration = ModelConfiguration(
            schema: fullSchema,
            groupContainer: .identifier("group.geniusoft.blockcall")
        )
        return try! ModelContainer(for: fullSchema, configurations: [modelConfiguration])
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
