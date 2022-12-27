//
//  main.swift
//  OC_VideoGame
//
//  Created by Maxime Girard on 29/11/2022.
//

import Foundation


public class Game {
    let players: [Player]
    private var numberOfTurns = 0
    
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
    public func start() {
        var currentPlayerIndex = 0
        var otherPlayerIndex = 1
        while players[0].teamIsAlive() && players[1].teamIsAlive() {
            players[0].fight(player: players[currentPlayerIndex], opponent: players[otherPlayerIndex])
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
        if players[0].teamIsAlive() {
            print("""
            ==================================
                  
            Player One has won the game !
                  
            ==================================
            """)
        } else {
            print("""
            ==================================

            Player Two has won the game !

            ==================================
            """)
        }
        
        players[0].displayTeam()
        players[1].displayTeam()
        print("The game lasted \(numberOfTurns) turns")
    }
}


let game = Game()
game.start()
