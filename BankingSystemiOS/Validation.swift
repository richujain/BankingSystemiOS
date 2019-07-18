//
//  Validation.swift
//  BankingSystemiOS
//
//  Created by Pat Abhishek on 2019-07-18.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import Foundation

//email Validation
extension String
{
    func isValidEmail() -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

// phone number validation
extension String{
    func isvalidPhoneNumber() -> Bool
    {
        var flag = false
        if self.count==10 {
            let number = Int(self)
            if number != nil {
                
                flag = true
            }
        }
        return flag
    }
}
