//
//  memorymindersApp.swift
//  memoryminders
//
//  Created by Brandon Marquez on 7/3/23.
//

import SwiftUI

@main
struct memorymindersApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
