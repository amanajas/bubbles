//
//  GameNumberUtil.swift
//  PrimaryBubble
//
//  Created by Thiago Amanajas on 8/7/14.
//  Copyright (c) 2014 Thiago Amanajas. All rights reserved.
//

import Foundation

class GameNumberUtil {
    
    private var primaryNumbers = [Int]();
    private var allNumbers = [Int]();
    
    private func generatePrimaryNumbers(min:Int, max:Int) {
        
        primaryNumbers = [Int]();
        allNumbers = [Int]();
        
        for var i = min; i < max; i++ {
            var isPrimeNumber = true
            for var j = 2; j < i; j++ {
                if (i % j == 0) {
                    isPrimeNumber = false
                    break
                }
            }
            if (isPrimeNumber) {
                primaryNumbers.append(i);
            }
            
            allNumbers.append(i);
        }
    }
    
    init(min:Int, max:Int) {
        generatePrimaryNumbers(min, max: max);
    }
    
    func getRandomNumber() -> Int {
        return allNumbers[Int(arc4random_uniform(UInt32(allNumbers.count)))];
    }
    
    func isPrimary(number:Int) -> Bool {
        return primaryNumbers.filter { $0 == number }.count > 0
    }
    
}
