//
//  WhatDaHuhApp.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 7/30/25.
//

import SwiftUI

@main
struct WhatDaHuhApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(Router())
        }
    }
}
