//
//  File.swift
//  StudingMVC
//
//  Created by Сергей Цыганков on 10.06.2020.
//  Copyright © 2020 Сергей Цыганков. All rights reserved.
//

import Foundation


struct Calculating {
    
    var elements = Constants()
    var signs = ["=",">","<",">=","<="]
    
    func makeCalculates(statment st: Bool) -> Bool {
        let one = elements.numberOne
        let two = elements.secondOne
        var statment = false
        switch elements.arrayOfSignsPosition {
        case 0:
            if one == two {
                statment = true
            }
            return search(st: st, result: statment)
            
        case 1:
            if one > two {
                statment = true
            }
            return search(st: st, result: statment)
            
        case 2:
            if one < two {
                statment = true
            }
            return search(st: st, result: statment)
            
        case 3:
            if one >= two {
                statment = true
            }
            return search(st: st, result: statment)
            
        case 4:
            if one <= two {
                statment = true
            }
            return search(st: st, result: statment)
        default:
            break
        }
        return false
    }
    
    private func search(st: Bool, result: Bool) -> Bool {
        if st == result {
            return true
        }
        return false
    }
    
}
