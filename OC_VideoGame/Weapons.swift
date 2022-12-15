//
//  Weapons.swift
//  OC_VideoGame
//
//  Created by Maxime Girard on 09/12/2022.
//

import Foundation

class Weapon {
    var name = ""
    var damagePoints = 0
    var healPoints = 0
}

class Sword: Weapon {
    override init() {
        super.init()
        self.damagePoints = 50
        self.name = "Sword"
    }
}

class Daggers: Weapon {
    override init() {
        super.init()
        self.damagePoints = 75
        self.name = "Daggers"
    }
}

class Staff: Weapon {
    override init() {
        super.init()
        self.damagePoints = 25
        self.name = "Staff"
        self.healPoints = 50
    }
}
