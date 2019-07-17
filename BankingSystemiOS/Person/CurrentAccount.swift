//
//  CurrentAccount.swift
//  BankingSystemiOS
//
//  Created by Ashish on 2019-07-17.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import Foundation
class CurrentAccount : BankAccount{
    var  personId: String?
    var  withdrawalLimit: Double?
    var  transactionCharges: Double?
    var interestRate: Double?
    var insufficientFundCharges: Double?;
    var  minimumBalance: Double?
    
    init(accountNumber: String,accountType: String,bankBranch:String, accountBalance: Double,personId: String,withdrawlLimit: Double,transactionCharges: Double,interestRate: Double,insufficientFundCharges: Double,minimumBalance: Double) {
        self.personId = personId
        super.init(accountNumber: String,accountType: String,bankBranch: String,accountBalance: Double)
        self.withdrawalLimit = withdrawlLimit
        self.transactionCharges = transactionCharges
        self.interestRate = interestRate
        self.insufficientFundCharges = insufficientFundCharges
        self.minimumBalance = minimumBalance
    }
    
}
