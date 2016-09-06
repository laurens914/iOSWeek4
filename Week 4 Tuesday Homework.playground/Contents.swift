//: Playground - noun: a place where people can play

import UIKit

var hawksArray = [3,4,9,25,29,56,72,89]

var test = [2,6,5,4,70,12,15]

func highLowArray(array:[Int]) -> (high: Int, low: Int)
{
    var high: Int
    
    
    var highNum: Int = Int()
    
    for number in array
        {
            if number == array.first
            {
                highNum = number
            } else {
                if number > highNum {
                    highNum = number
                }
            }
        }
    high = highNum

var low:Int
    var lowNum: Int = Int()
    
    for number in array
    {
        if number == array.first
        {
            lowNum = number
        } else{
            if number < lowNum{
                lowNum = number
            }
        }
    }
    low = lowNum

   return (high,low)
}





highLowArray(hawksArray)
highLowArray(test)
