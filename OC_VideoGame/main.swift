//
//  main.swift
//  OC_VideoGame
//
//  Created by Maxime Girard on 29/11/2022.
//

import Foundation

// Function used to force the user to write a number for readLine instead of allowing a String
func readInteger() -> Int? {
    if let integerString = readLine() {
        if let int = Int(integerString) {
            return int
        } else {
            print("Please enter a number")
            return readInteger()
        }
    }
    return nil
}


class Game {
    var players: [Player]
    
    init() {
        print("""
        Welcome to game !
        .
        .
        Use any key on your keyboard to start playing.
        """)
        _ = readLine()
        print("Player One will start by creating a team of 3 characters with a unique name and one determined character archetype.")
        let playerOne = Player(name: "Player One")
        print(
            """
            =======================================
            
            Player Two will now start creating a team of 3 characters with a unique name and one determined character archetype.
            
            =======================================
            """)
        let playerTwo = Player(name: "Player Two")
        self.players = [playerOne, playerTwo]
        
        //Allows us to keep players playing or to stop the game if one player's team is dead
        var currentPlayerIndex = 0
        while players[0].team.isAlive() && players[1].team.isAlive() {
            fight(player: players[currentPlayerIndex])
            if currentPlayerIndex == 0 {
                currentPlayerIndex = 1
            } else {
                currentPlayerIndex = 0
            }
        }
        // Checks if the first player's is alive and prints its victory, otherwise it prints player two's
        if players[0].team.isAlive() {
            print("Player One has won the game !")
        } else {
            print("Player Two has won the game !")
        }
    }
    
    //Function used to determine what happens during a fight
    func fight(player: Player) {
        
    }
}

class Player{
    var name: String?
    let team: Team
    
    init(name: String = "") {
        self.name = name
        self.team = Team()
    }
}


class Team {
    var charactersLength = 3
    var characters: [Character] = []

    //Used to add each newly created character and its data into the table Character, also prints its name
    init() {
        print("Player will now create 3 characters.")
        for i in 0..<charactersLength {
            if let charac = createCharacter(characterNumber: i+1) {
                characters.append(charac) //On rajoute le personnage créer dans le tableau characters
                Character.namesTaken.append(charac.name) //On rajoute le nom de chaque personnage dans le tableau namesTaken
                print("\(charac.whoAmI()).")
            }
        }
    }
    
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
            if Character.namesTaken.contains(characterName) {
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
        You can choose one of these archetypes for \(characterName):
        1. Warrior - Has a lot of HP and deals a good amount of damage with its Sword.
        2. Thief - Has a medium amount of HP but deals tremendous damage with its Daggers.
        3. Mage - Has very few HP and deals little damage with its Staff but grants the ability to heal self or others.
        
        
        What archetype do you choose for \(characterName) ?
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
                print("Please enter a number between 1 and 3.")
                character = askCharacterType(characterName: characterName)
            }
            return character
        }
        return nil
    }
    
    
    // Function to create a complete character with a name and character type based on 2 different functions
    func createCharacter(characterNumber: Int) -> Character? {
        if let characterName = askCharacterName(characterNumber: characterNumber) {
            return askCharacterType(characterName: characterName)
        }
        return nil
    }
    
    func isAlive() -> Bool {
//        return characters.contains { charac in
//            return charac.hitpoints > 0
//        }
        for charac in characters {
            if charac.hitpoints > 0 {
                return true
            }
        }
        return false
    }
}

class Character {
    var name:  String
    static var namesTaken: [String] = [] //Allows us to store each name produced by user and check if its been used for another character
    var hitpoints = 0
    var weapon: Weapon?
    
    init(name: String) {
        self.name = name
    }
    
    func attack() {
        
    }
    
    func heal () {
        
    }
    
    // Function called for each type of character created
    func whoAmI() -> String {
        return "I am a generic character named \(name)."
    }
}

class Warrior: Character {
    override init(name: String) {
        super.init(name: name)
        self.hitpoints = 1000
        self.weapon = Sword()
    }
    
    // Overriding generic function, to display a message when a certain character type is selected
    override func whoAmI() -> String {
        return "I am a warrior named \(name)."
    }
}

class Thief: Character {
    override init(name: String) {
        super.init(name: name)
        self.hitpoints = 750
        self.weapon = Daggers()
    }
    override func whoAmI() -> String {
        return "I am a thief named \(name)."
    }
}

class Mage: Character {
    override init(name: String) {
        super.init(name: name)
        self.hitpoints = 500
        self.weapon = Staff()
    }
    override func whoAmI() -> String {
        return "I am a mage named \(name)."
    }
}

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
        self.healPoints = 75
    }
}

let game = Game()

