//
//  Player.swift
//  OC_VideoGame
//
//  Created by Maxime Girard on 07/12/2022.
//

import Foundation

class Player {
    let name: String
    private let charactersLength = 3
    var characters: [Character] = []
    
    init(name: String) {
        self.name = name
        print("Player will now create 3 characters.")
        for i in 0..<charactersLength {
            if let charac = createCharacter(characterNumber: i+1) {
                characters.append(charac) //We add the created character in the array called characters
                print("\(charac.whoAmI())")
            }
        }
    }
    
    func displayTeam() {
        for (_, charac) in characters.enumerated() {
            print("""
            \(charac.name) - \(charac.typeName.rawValue), \(charac.hitpoints) HP, \(charac.sumDMG()) damage dealt and \(charac.sumHL()) damage healed
            """)
        }
    }
    
    
    func chooseAction(character: Character) -> Character.Actions  {
        return character.chooseAction()
    }
    
    func chooseTarget(action: Character.Actions, opponent: Player) -> Character {
        var potentialTargets: Player
        switch action {
        case .attack:
            potentialTargets = opponent.self
        case .heal:
            potentialTargets = self
        }
        print("""
        .
        .
        .
        .
        Which character will you \(action) ?
        .
        """)
        return potentialTargets.chooseCharacter()
    }

    //Used to add each newly created character and its data into the table Character, also prints its name

    
    // Function used to let player decide of the character name
    func askCharacterName(characterNumber: Int) -> String? {
        
        print(
            """
            Create character n°\(characterNumber):
            .
            .
            .
            What is the name of your character ?
            """
        )
        //Function used to let the player give a name to its character. Name is then checked for unicity and restart creation if already taken
        if let characterName = readLine() {
            if characterName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                print("You must type a name for your character.")
                return askCharacterName(characterNumber: characterNumber)
            }
            if characters.contains(where: { character in
                character.name == characterName
            }) {
                print("This name has already been given, choose another.")
                return askCharacterName(characterNumber: characterNumber)
            } else {
                print("This character is named \(characterName)")
                return characterName
            }
        }
        return nil
    }
    
    // Function used to let the player select an archetype for its character
    func askCharacterType(characterName: String) -> Character? {
        print("""
        .
        .
        .
        You can choose one of these archetypes for \(characterName):
        1. Warrior - Has a lot of HP and deals a good amount of damage with its Sword.
        2. Thief - Has a medium amount of HP but deals tremendous damage with its Daggers.
        3. Mage - Has very few HP and deals little damage with its Staff but grants the ability to heal self or others.
        
        
        What archetype do you choose for \(characterName) ?
        .
        .
        .
        """)
        // As stated in readInteger() function, player must insert a number within 1 to 3 to select an archetype for its character
        if let choice = readInteger() {
            var character: Character?
            switch choice {
            case 1:
                character = Warrior(name: characterName)
            case 2:
                character = Thief(name: characterName)
            case 3:
                character = Mage(name: characterName)
            default:
                print("""
                .
                .
                .
                Please enter a number between 1 and 3.
                .
                .
                .
                """)
                character = askCharacterType(characterName: characterName)
            }
            return character
        }
        return nil
    }
    
    
    // Function to create a complete character with a name and character type based on 2 different functions
    private func createCharacter(characterNumber: Int) -> Character? {
        if let characterName = askCharacterName(characterNumber: characterNumber) {
            return askCharacterType(characterName: characterName)
        }
        return nil
    }
    
    func teamIsAlive() -> Bool {
        return characters.contains { charac in
            return charac.hitpoints > 0
        }
    }
    
    func chooseCharacter() -> Character {
        print("""
        .
        .
        .
        Which character will you select ?
        .
        """)
        for (i, charac) in characters.enumerated() {
            if charac.hitpoints <= 0 {
                print("\(i + 1): \(charac.name) - \(charac.typeName) : Dead ")
            } else {
                print("\(i + 1): \(charac.name) - \(charac.typeName) : \(charac.hitpoints) HP")
            }
        }
        if let choice = readInteger() {
            if !(1...charactersLength).contains(choice) {
                print("You must choose a valid character.")
                return chooseCharacter()
            }
            let chosenCharacter = characters[choice - 1]
            if chosenCharacter.hitpoints <= 0 {
                print("This character is dead and cannot play.")
                return chooseCharacter()
            }
            return chosenCharacter
        }
        print("You must choose a character.")
        return chooseCharacter()
    }
    
    //Function used to determine what happens during a fight
    func fight(player: Player, opponent: Player) {
        let selectedHero = player.chooseCharacter()
        let action = player.chooseAction(character: selectedHero)
        let target = player.chooseTarget(action: action, opponent: opponent)
        
        selectedHero.performAction(action: action, target: target, character: selectedHero)
        
    }

}
