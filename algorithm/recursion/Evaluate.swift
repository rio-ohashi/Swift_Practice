//
//  Evaluate.swift
//  algorithm
//
//  Created by Rio on 2020-02-12.
//  Copyright © 2020 Rio. All rights reserved.
//

import Foundation


func getRightIndex(str:String, start:Int)->Int {
    var leftCount = 0
    for i in start..<str.count {
        if (str[i]  == "(") {
            leftCount += 1
        } else if (str[i]  == ")") {
            if (leftCount == 1) {
                return i
            } else {
                leftCount -= 1
            }
        }
    }
    return -1
}

func evaluate(_ str: String) -> Int {
    if str.count == 1 { return Int(str)! }
    var i = 0
    var total = 0
    for _ in i..<str.count {
        if str[i] == "(" {
            let endIndex = getRightIndex(str: str, start:i)
            total = evaluate(str[i+1, endIndex])
            i = endIndex - i + 1
        } else {
            switch str[i] {
            case "+":
                if str[i+1] == "(" {
                    let endIndex = getRightIndex(str: str, start:i+1)
                    if str[i-1] == ")" {
                        total += evaluate(str[i+2, endIndex])
                    } else {
                        total = Int(str[i-1])! + evaluate(str[i+2, endIndex])
                    }
                    i = endIndex
                } else {
                    if str[i-1] == ")" {
                        total += Int(str[i+1])!
                    } else {
                        total = Int(str[i-1])! + Int(str[i+1])!
                    }
                    i += 1
                }
            case "*":
                if str[i+1] == "(" {
                    let endIndex = getRightIndex(str: str, start:i+1)
                    if str[i-1] == ")" {
                        total *= evaluate(str[i+2, endIndex])
                    } else {
                        total = Int(str[i-1])! * evaluate(str[i+2, endIndex])
                    }
                    i = endIndex
                } else {
                    if str[i-1] == ")" {
                        total *= Int(str[i+1])!
                    } else {
                        total = Int(str[i-1])! * Int(str[i+1])!
                    }
                    i += 1
                }
            default:
                i += 1
            }
        }
        if (i >= str.count-1) {
            return total
        }
    }
    return total
}


/*
 (1+(1+(1+1)+(1))+1)
 (2*(1+(1+1)+(1))+1)
 
 
 */
