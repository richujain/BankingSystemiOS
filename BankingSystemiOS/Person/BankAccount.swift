//
//  BankAccount.swift
//  BankingSystemiOS
//
//  Created by Ashish on 2019-07-17.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import Foundation
class BankAccount{
    var accountNumber: String?
    var accountType: String?
    var bankBranch: String?
    var accountBalance: Double?
    init(accountNumber: String,accountType: String,bankBranch: String,accountBalance: Double) {
        self.accountNumber = accountNumber
        self.accountType = accountType
        self.bankBranch = bankBranch
        self.accountBalance = accountBalance
    }
}
