//
//  utils.swift
//  OC_VideoGame
//
//  Created by Maxime Girard on 15/12/2022.
//

import Foundation

// Function used to force the user to write a number for readLine instead of allowing a String
public func readInteger() -> Int? {
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
