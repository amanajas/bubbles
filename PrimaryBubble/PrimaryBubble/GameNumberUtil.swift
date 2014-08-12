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
    }
    
    // Return a random number.
    func getRandomNumber() -> Int {
        return allNumbers[Int(arc4random_uniform(UInt32(allNumbers.count)))];
    }
    
    // Check if the number is prime.
    func isPrime(number:Int) -> Bool {
        return primeNumbers.filter { $0 == number }.count > 0
    }
    
}
