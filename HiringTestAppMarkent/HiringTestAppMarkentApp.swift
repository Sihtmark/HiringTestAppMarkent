//
//  HiringTestAppMarkentApp.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-07.
//

import SwiftUI

@main
struct HiringTestAppMarkentApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(vm)
        }
    }
}
