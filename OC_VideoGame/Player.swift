//
//  Player.swift
//  OC_VideoGame
//
//  Created by Maxime Girard on 07/12/2022.
//

import Foundation

class Player {
    let name: String
    let team: Team
    
    
    init(name: String) {
        self.name = name
        self.team = Team()
    }
    
    func chooseCharacter() -> Character {
        print("""
        .
        .
        .
        Which character will play this turn ?
        .
        """)
        return team.chooseCharacter()
    }
    
    
    func chooseAction(character: Character) -> Character.Actions  {
        return character.chooseAction()
    }
    
    func chooseTarget(action: Character.Actions, opponent: Player) -> Character {
        var potentialTargets: Team
        switch action {
        case .attack:
            potentialTargets = opponent.team
        case .heal:
            potentialTargets = team
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
}
