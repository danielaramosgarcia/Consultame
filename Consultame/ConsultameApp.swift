//
//  ConsultameApp.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 17/10/23.
//

import SwiftUI

@main
struct ConsultameApp: App {
//    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            WelcomPageView()
//                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
