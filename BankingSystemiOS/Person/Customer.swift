//
//  Customer.swift
//  BankingSystemiOS
//
//  Created by Ashish on 2019-07-17.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import Foundation
class Customer: Person {
    var  photoAddressProofId:String
    
    
    init(personId: String, personName: String, address: String, birthDate: String, contactNumber: String, emailId: String,photoAddressProofId: String) {
        self.photoAddressProofId  = photoAddressProofId
        super.init(personId: personId, personName: personName, address: address, birthDate: birthDate, contactNumber: contactNumber, emailId: emailId)
        self.personId = personId
        self.personName =  personName
        self.address = address
        self.birthDate = birthDate
        self.contactNumber = contactNumber
        self.emailId = emailId
    }
    
}
