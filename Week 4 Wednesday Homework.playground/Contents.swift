//: Playground - noun: a place where people can play

import UIKit
//
//Given a non-negative number "num", return true if num is within 2 of a multiple of 10. Note: (a % b) is the remainder of dividing a by b, so (7 % 5) is 2


func multipleOfTen(num:Int) -> Bool
{
    if num % 10 == 8{
        return true
    } else if num % 10 == 9 {
        return true
    } else if num % 10 == 0 {
        return true
    } else if num % 10 == 1{
        return true
    } else if num % 10 == 2{
        return true
    } else {
        return false
    }
}

multipleOfTen(12)
multipleOfTen(8)
multipleOfTen(9)
multipleOfTen(10)
multipleOfTen(11)
multipleOfTen(13)
multipleOfTen(20)
multipleOfTen(24)
multipleOfTen(18)
