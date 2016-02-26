//: Playground - noun: a place where people can play

import UIKit

func doubleChar(string: String)->String
{
    var doubleString = ""
    for character in string.characters{
        doubleString.append(character)
        doubleString.append(character)
    }
    
        return doubleString
}


doubleChar("test")
doubleChar("Seahawks")
