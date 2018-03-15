//
//  AppCategory.swift
//  YouTube
//
//  Created by MAC on 3/11/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import Foundation

class AppStore: Decodable {
    var categories: [AppCategory]?
}

class AppCategory: Decodable {
    var name: String?
    var type: String?
    var apps: [App]?
    
    static func fetchFeatureApps(completion: @escaping (AppStore) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let appStore = try JSONDecoder().decode(AppStore.self, from: data)
                DispatchQueue.main.async {
                    completion(appStore)
                }
            } catch let err {
                print("error serializing json, \(err.localizedDescription)")
            }
            }.resume()
    }
    
    static func sampleAppCategories() -> [AppCategory] {
        let bestNewAppsCategory = AppCategory()
        bestNewAppsCategory.name = "Best New Apps"
        
        var apps = [App]()
        
        let fronzenApp = App()
        fronzenApp.Name = "Disney Build It: Fronzen"
        fronzenApp.ImageName = "fronze"
        fronzenApp.Category = "Entertaiment"
        fronzenApp.Price = 3.99
        apps.append(fronzenApp)
        bestNewAppsCategory.apps = apps
        
        
        let bestNewGamesCategory = AppCategory()
        bestNewGamesCategory.name = "Best New Games"
        
        var bestNewGameApps = [App]()
        
        let telepaintApp = App()
        telepaintApp.Name = "Telepaint"
        telepaintApp.Category = "Games"
        telepaintApp.ImageName = "kanye_profile"
        telepaintApp.Price = 2.99
        bestNewGameApps.append(telepaintApp)
        bestNewGamesCategory.apps = bestNewGameApps
        
        return [bestNewAppsCategory, bestNewGamesCategory]
    }
}

class App: Decodable {
    var Id: Int?
    var Name: String?
    var Category: String?
    var ImageName: String?
    var Price: Double?
}
