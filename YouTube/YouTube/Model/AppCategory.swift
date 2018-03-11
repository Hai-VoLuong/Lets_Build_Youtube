//
//  AppCategory.swift
//  YouTube
//
//  Created by MAC on 3/11/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import Foundation

class AppCetegory {
    var name: String?
    var apps: [App]?
    
    static func sampleAppCategories() -> [AppCetegory] {
        let bestNewAppsCategory = AppCetegory()
        bestNewAppsCategory.name = "Best New Apps"
        
        var apps = [App]()
        
        let fronzenApp = App()
        fronzenApp.name = "Disney Build It: Fronzen"
        fronzenApp.imageName = "fronze"
        fronzenApp.category = "Entertaiment"
        fronzenApp.price = 3.99
        apps.append(fronzenApp)
        bestNewAppsCategory.apps = apps
        
        
        let bestNewGamesCategory = AppCetegory()
        bestNewAppsCategory.name = "Best New Games"
        
        var bestNewGameApps = [App]()
        
        let telepaintApp = App()
        telepaintApp.name = "Telepaint"
        telepaintApp.category = "Games"
        telepaintApp.imageName = "Telepaint"
        telepaintApp.price = 2.99
        bestNewGameApps.append(telepaintApp)
        bestNewGamesCategory.apps = bestNewGameApps
        
        return [bestNewAppsCategory, bestNewAppsCategory]
    }
}

class App {
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
}
