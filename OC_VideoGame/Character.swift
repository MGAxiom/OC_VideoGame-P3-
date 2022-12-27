//
//  Character.swift
//  OC_VideoGame
//
//  Created by Maxime Girard on 07/12/2022.
//

import Foundation


class Character {
    let name: String
    let typeName: CharacterType
    var hitpoints = 0
    let weapon: Weapon
    var allowedActions: [Actions] = []
    private var damageDealt: [Int] = []
    private var damageHealed: [Int] = []
    
    
    fileprivate init(name: String, weapon: Weapon, typeName: CharacterType) {
        self.name = name
        self.weapon = weapon
        self.typeName = typeName
    }
    
    enum Actions {
        case attack
        case heal
    }
    
    enum CharacterType: String {
        case Warrior
        case Thief
        case Mage
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
        return "I am a \(typeName.rawValue.lowercased()) named \(name)."
    }
    
    func sumDMG() -> Int {
        damageDealt.reduce(0, +)
    }
    
    func sumHL() -> Int {
        damageHealed.reduce(0, +)
    }
}

final class Warrior: Character {
    init(name: String) {
        super.init(name: name, weapon: Sword(), typeName: CharacterType.Warrior)
        self.hitpoints = 350
        self.allowedActions = [.attack]
    }
}

final class Thief: Character {
    init(name: String) {
        super.init(name: name, weapon: Daggers(), typeName: CharacterType.Thief)
        self.hitpoints = 250
        self.allowedActions = [.attack]
    }
}

final class Mage: Character {
    init(name: String) {
        super.init(name: name, weapon: Staff(), typeName: CharacterType.Mage)
        self.hitpoints = 100
        self.allowedActions = [.attack, .heal]
    }
}

