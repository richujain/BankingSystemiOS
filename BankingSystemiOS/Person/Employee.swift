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
    
    init(personId: String, personName: String, address: String, birthDate: String, contactNumber: String, emailId: String,designation: String,salary: Double,username: String,password: String,bankBranch: String) {
        self.designation  = designation
        self.salary = salary
        self.username = username
        self.password = password
        self.bankBranch = bankBranch
        super.init(personId: personId, personName: personName, address: address, birthDate: birthDate, contactNumber: contactNumber, emailId: emailId)
        self.personId = personId
        self.personName =  personName
        self.address = address
        self.birthDate = birthDate
        self.contactNumber = contactNumber
        self.emailId = emailId
    }
}
