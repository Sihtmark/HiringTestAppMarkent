//
//  HiringTestAppMarkentApp.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-07.
//

import SwiftUI

@main
struct HiringTestAppMarkentApp: App {
    
    @StateObject private var vm = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if vm.user == nil {
                    LoginView()
                } else {
                    HomeView()
                }
            }
            .environmentObject(vm)
        }
    }
}
