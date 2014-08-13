//
//  GameNumberUtil.swift
//  PrimaryBubble
//
//  Created by Thiago Amanajas on 8/7/14.
//  Copyright (c) 2014 Thiago Amanajas. All rights reserved.
//

import Foundation

class GameNumberUtil {
    
    // Used to balance the creation of numbers
    private var maxNormalNumbersCount : Int = 0
    
    // Used to count the normal numbers
    private var numbersCount : Int = 0
    
    /*
        This is the prime number list that is used
        check if a number is prime.
    */
    private var primeNumbers = [Int]();
    
    /*
        This list is used to get a random number.
    */
    private var allNumbers = [Int]();
    
    
    init(min:Int, max:Int) {
        generateNumbers(min, max: max);
    }
    
    /*
        This method generates a range of numbers
        and separates the prime numbers.
    */
    private func generateNumbers(min:Int, max:Int) {
        
        primeNumbers = [Int]();
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
                primeNumbers.append(i);
            }
            
            allNumbers.append(i);
        }
        
        // Calculates the maximum of normal numbers must to be created before the prime numbers.
        maxNormalNumbersCount = 1 + Int(GameConstants.DEFAULT_GAME_TIME) /
            ((primeNumbers.count * 100) / allNumbers.count)
    }
    
    // Return a random number.
    func getRandomNumber() -> Int {
        
        var number = allNumbers[Int(arc4random_uniform(UInt32(allNumbers.count)))]
        numbersCount = !isPrime(number.description) ? numbersCount + 1 : 0
        if numbersCount > Int(arc4random()) % maxNormalNumbersCount {
            number = primeNumbers[Int(arc4random_uniform(UInt32(primeNumbers.count)))]
            numbersCount = 0
        }
        
        return number
    }
    
    // Check if the number is prime.
    func isPrime(number:String) -> Bool {
        return primeNumbers.filter { $0 == number.toInt() }.count > 0
    }
    
}
