//
//  Character.swift
//  OC_VideoGame
//
//  Created by Maxime Girard on 07/12/2022.
//

import Foundation

class Character {
    let name:  String
    var typeName = ""
    var namesTaken: [String] = [] //Allows us to store each name produced by user and check if its been used for another character
    var hitpoints = 0
    var weapon: Weapon
    var allowedActions: [Actions] = []
    var damageDealt: [Int] = []
    var damageHealed: [Int] = []
    
    
    init(name: String, weapon: Weapon) {
        self.name = name
        self.weapon = weapon
    }
    
    enum Actions {
        case attack
        case heal
    }
    
    func chooseAction() -> Actions {
        print("What action will you choose ?")
        for (i, Actions) in allowedActions.enumerated() {
            print("\(i+1): \(Actions)")
        }
        if let choice = readInteger() {
            if !(1...allowedActions.count).contains(choice) {
                print("You must choose a valid action.")
                return chooseAction()
            }
            return allowedActions[choice - 1]
        }
        return chooseAction()
    }
    
    func performAction(action: Actions, target: Character, character: Character) {

        switch action {
        case .attack:
            target.hitpoints -= weapon.damagePoints
            damageDealt.append(weapon.damagePoints)
            print("\(character.name) \(action)s \(target.name)")
            print("\(target.name) lost \(weapon.damagePoints) HP and now has \(target.hitpoints) HP.")
        case .heal:
            target.hitpoints += weapon.healPoints
            damageHealed.append(weapon.healPoints)
            print("\(character.name) \(action)s \(target.name)")
            print("\(target.name) has been healed for \(weapon.healPoints) HP and now has \(target.hitpoints) HP.")
        }
    }

    
    // Function called for each type of character created
    func whoAmI() -> String {
        return "I am a generic character named \(name)."
    }
    
    func sumDMG() -> Int {
        damageDealt.reduce(0, +)
    }
    
    func sumHL() -> Int {
        damageHealed.reduce(0, +)
    }
}

class Warrior: Character {
    convenience init(name: String) {
        self.init(name: name, weapon: Sword())
        self.typeName = "Warrior"
        self.hitpoints = 1000
        self.allowedActions = [.attack]
    }
    
    // Overriding generic function, to display a message when a certain character type is selected
    override func whoAmI() -> String {
        return "I am a warrior named \(name)."
    }
}

class Thief: Character {
    convenience init(name: String) {
        self.init(name: name, weapon: Daggers())
        self.typeName = "Thief"
        self.hitpoints = 750
        self.allowedActions = [.attack]
    }
    override func whoAmI() -> String {
        return "I am a thief named \(name)."
    }
}

class Mage: Character {
    convenience init(name: String) {
        self.init(name: name, weapon: Staff())
        self.typeName = "Mage"
        self.hitpoints = 500

        self.allowedActions = [.attack, .heal]
    }
    override func whoAmI() -> String {
        return "I am a mage named \(name)."
    }
}


