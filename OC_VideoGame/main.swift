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
    var numberOfTurns = 0
    
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

    }

    //Allows us to keep players playing or to stop the game if one player's team is dead
    func start() {
//        var currentPlayer = players[0]
//        var otherPlayer = players[1]
//        while currentPlayer.team.isAlive() && otherPlayer.team.isAlive() {
//            fight(player: currentPlayer, opponent: otherPlayer)
//            let tmpPlayer = currentPlayer
//            currentPlayer = otherPlayer
//            otherPlayer = tmpPlayer
//        }
//
        
        
        
        
        var currentPlayerIndex = 0
        var otherPlayerIndex = 1
        while players[0].team.isAlive() && players[1].team.isAlive() {
            fight(player: players[currentPlayerIndex], opponent: players[otherPlayerIndex])
            if currentPlayerIndex == 0 {
                currentPlayerIndex = 1
                otherPlayerIndex = 0
            } else {
                currentPlayerIndex = 0
                otherPlayerIndex = 1
            }
            numberOfTurns += 1
        }
        
        // Checks if the first player's is alive and prints its victory, otherwise it prints player two's
        if players[0].team.isAlive() {
            print("""
            ==================================
                  
            Player One has won the game !
                  
            ==================================
            """)
            displayStats(player: players[0], opponent: players[1])
        } else {
            print("""
            ==================================

            Player Two has won the game !

            ==================================
            """)
            displayStats(player: players[1], opponent: players[0])
        }
    }
    
    //Function used to determine what happens during a fight
    func fight(player: Player, opponent: Player) {
        let selectedHero = player.chooseCharacter()
        let action = player.chooseAction(character: selectedHero)
        let target = player.chooseTarget(action: action, opponent: opponent)
        
        selectedHero.performAction(action: action, target: target, character: selectedHero)
        
    }
    
    func displayStats(player: Player, opponent: Player) {
        for (_, charac) in player.team.characters.enumerated() {
            print("""
            \(charac.name) - \(charac.typeName) - \(charac.sumDMG()) damage dealt and \(charac.sumHL()) damage healed
            """)
        }
        for (_, charac) in opponent.team.characters.enumerated() {
            print("""
            \(charac.name) - \(charac.typeName) - \(charac.sumDMG()) damage dealt and \(charac.sumHL()) damage healed
            """)
        }
        print("""
        
        The game lasted \(numberOfTurns) turns.

        """)
    }
}


let game = Game()
game.start()
