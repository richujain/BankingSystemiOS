//
//  Employee.swift
//  BankingSystemiOS
//
//  Created by Ashish on 2019-07-17.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import Foundation
class Employee: Person {
    var designation: String?
    var salary: Double?
    var username: String?
    var password: String?
    var bankBranch: String?
    
    
    init() {
        self.designation = String()
        self.salary = Double()
        self.username = String()
        self.password = String()
        self.bankBranch = String()
        
        super.init(personId: "0", personName: "0", address: "0", birthDate: "0", contactNumber: "0", emailId: "0")
    }
}
