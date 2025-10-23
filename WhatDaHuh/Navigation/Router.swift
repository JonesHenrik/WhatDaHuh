//
//  Router.swift
//  WhatDaHuh
//
//  Created by Henrik Jones on 8/6/25.
//

import Foundation
import SwiftUI

/// Represents the different destinations in the navigation stack.
enum Route: Hashable {
    case main
    case word(Word)
    case wordList
    case badge(Badge)
    case badgeGrid
}

@Observable
class Router: ObservableObject {
    
    /// The current navigation path used for programmatic navigation.
    var path = NavigationPath()
    
    /// Navigates to a specific route by appending it to the path.
    ///
    /// - Parameter route: The destination route to navigate to.
    func navigate(to route: Route) {
        path.append(route)
    }
    
    /// Navigates back to the previous screen by subtracting one view off the path count.
    ///
    /// if the view has more than 2 views it will subract one but if it has 1 it will go to root view.
    func navigateBack() {
        if path.count >= 2{
            path.removeLast(path.count - 1)
        } else {
            path.removeLast(path.count)
        }
    }
    
    /// Navigates to the root view by removing all views from the navigation path.
    ///
    /// Equivalent to `navigateBack()` in current implementation.
    func navigateToRoot() {
        path.removeLast(path.count)
    }
    /// Pops a specific number of views from the navigation stack.
    ///
    /// - Parameter count: The number of views to remove from the navigation stack.
    func popToView(count: Int) {
        path.removeLast(count)
    }
    
    /// Indicates whether navigation back is possible.
    ///
    /// - Returns: `true` if there are any views in the navigation stack, otherwise `false`.
    func canNavigateBack() -> Bool {
        return path.count > 0
    }
}

