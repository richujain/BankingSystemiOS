//
//  Person.swift
//  BankingSystemiOS
//
//  Created by Ashish on 2019-07-17.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import Foundation
class Person {
    var personId:String
    var personName:String
    var address:String
    var birthDate:String
    var contactNumber:String
    var emailId:String
    init(personId : String , personName : String , address : String , birthDate : String , contactNumber : String , emailId : String) {
        self.personId = String()
        self.personName = String()
        self.address = String()
        self.birthDate = String()
        self.contactNumber = String()
        self.emailId = String()
    }
}
