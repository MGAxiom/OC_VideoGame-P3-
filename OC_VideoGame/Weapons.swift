//
//  Weapons.swift
//  OC_VideoGame
//
//  Created by Maxime Girard on 09/12/2022.
//

import Foundation

class Weapon {
    let name: String
    let damagePoints: Int
    let healPoints: Int
    
    init(name: String, damagePoints: Int, healPoints: Int) {
        self.name = name
        self.damagePoints = damagePoints
        self.healPoints = healPoints
    }
}

class Sword: Weapon {
    init() {
        super.init(name: "Sword", damagePoints: 50, healPoints: 0)
    }
}

class Daggers: Weapon {
    init() {
        super.init(name: "Daggers", damagePoints: 75, healPoints: 0)
    }
}

class Staff: Weapon {
    init() {
        super.init(name: "Staff", damagePoints: 25, healPoints: 50)
    }
}
