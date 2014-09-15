//
//  GameNumberUtil.swift
//  PrimaryBubble
//
//  Created by Thiago Amanajas on 8/7/14.
//  Copyright (c) 2014 Thiago Amanajas. All rights reserved.
//

import Foundation

class GameNumberUtil {
    
    /*
        This is the prime number list that is used
        to generate a number
    */
    private var primeNumbers = [Int]();
    
    /*
        This is the prime number backup list that is used
        check if a number is prime.
    */
    private var lastPrimeNumbers = [Int]();
    
    /*
        This list is used to get a random number.
    */
    private var allNumbers = [Int]();
    
    
    /*
        This method generates a range of numbers
        and separates the prime numbers.
    */
    private func generateNumbers() {
        
        primeNumbers = [Int]();
        allNumbers = [Int]();
        
        for var i = GameConstants.MIN_NUMBER; i < GameConstants.MAX_NUMBER; i++ {
            var isPrimeNumber = true
            for var j = 2; j < i; j++ {
                if (i % j == 0) {
                    isPrimeNumber = false
                    break
                }
            }
            
            if (isPrimeNumber) {
                primeNumbers.append(i);
            }
            
            allNumbers.append(i);
        }
        
        lastPrimeNumbers = primeNumbers
    }
    
    private func random(total:Int) -> Int {
        return Int(arc4random_uniform(UInt32(total)))
    }
    
    // Return a random number.
    func getRandomNumber() -> Int {
        
        if (allNumbers.count == 0 || primeNumbers.count == 0) {
            generateNumbers()
        }
        
        var index = random(allNumbers.count)
        var number = allNumbers[index]
        if random(primeNumbers.count) % 3 == 0 {
            index = random(primeNumbers.count)
            number = primeNumbers[index]
            primeNumbers.removeAtIndex(index)
        } else {
            allNumbers.removeAtIndex(index)
        }
        
        return number
    }
    
    // Check if the number is prime.
    func isPrime(number:String) -> Bool {
        return lastPrimeNumbers.filter { $0 == number.toInt() }.count > 0
    }
    
    func reset() {
        generateNumbers()
    }
    
}
