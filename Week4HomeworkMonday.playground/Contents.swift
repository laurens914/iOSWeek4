//: Playground - noun: a place where people can play

import UIKit

func returnThreeArray(array:[AnyObject]) -> [AnyObject]
{
    let arrayCount = array.count
    let devided = 2
    let middleIndex = arrayCount/devided
    let previousNumber = middleIndex - 1
    let nextNumber = middleIndex + 1
    return [array[previousNumber], array[middleIndex],array[nextNumber]]

    
}


let testArray = [1,2,3,4,5]
let seahawksPlayerNumbers = [3,4,16,25,29,31,89]

returnThreeArray(testArray)
returnThreeArray(seahawksPlayerNumbers)
