//
//  DepositViewController.swift
//  BankingSystemiOS
//
//  Created by Pat Abhishek on 2019-07-21.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DepositViewController: UIViewController {
    @IBOutlet weak var txtAccountNumber: UITextField!
    @IBOutlet weak var labelAccountHolder: UILabel!
    @IBOutlet weak var btnDepositOutlet: UIButton!
    @IBOutlet weak var labelContactNumber: UILabel!
    @IBOutlet weak var txtAmountToDeposit: UITextField!
    typealias completion = (_ isFinished:Bool) -> Void
    var flag:Int = 0
    var ref: DatabaseReference!
    var isValidAccount: Bool = false
    var accountNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnDepositOutlet.isHidden = true
        txtAmountToDeposit.isHidden = true
        ref = Database.database().reference()
    }
    func getAccountType(ref: DatabaseReference, completionHandler: @escaping completion) {
        flag = 0
        
        ref.child("bank").child("savings").child(self.accountNumber).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            var acc = "0"
            acc = value?["accountnumber"] as? String ?? ""
            if Int(acc) ?? 0 > 0{
                self.flag = 1
                //return "current"
                completionHandler(true)
            }
            //let user = User(username: username)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
       
        ref.child("bank").child("current").child(self.accountNumber).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            var acc = "0"
            acc = value?["accountnumber"] as? String ?? ""
            if Int(acc) ?? 0 > 0{
                self.flag = 2
                //return "savings"
                completionHandler(true)
            }
            
            
            //let user = User(username: username)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    @IBAction func btnDepositButton(_ sender: Any) {
        if txtAccountNumber.text!.isEmpty{
            let alert=UIAlertController(title: "Error", message: "Enter Account Number", preferredStyle: UIAlertController.Style.alert)
            let actionok=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionok)
            self.present(alert,animated: true,completion: nil)
        }
        else if txtAmountToDeposit.text!.isEmpty{
            let alert=UIAlertController(title: "Error", message: "Enter Amount to Deposit", preferredStyle: UIAlertController.Style.alert)
            let actionok=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionok)
            self.present(alert,animated: true,completion: nil)
        }
        else{
            let accountNumber = txtAccountNumber.text
            let amountToDeposit = txtAmountToDeposit.text
            getAccountType(ref: ref, completionHandler: { (isFinished) in
                if isFinished {
                    print("Account Type is \(self.flag)")
                    
                }
            })
            var accountType: String = ""
            if flag == 1{
                accountType = "savings"
            }
            else{
                accountType = "current"
            }
            var balance: String = "0.0"
            ref.child("bank").child(accountType).child(self.accountNumber).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                balance = value?["accountnumber"] as? String ?? ""
                let sum: Double = Double(balance) + Double(amountToDeposit!) ?? 0.0
                
                
                
                //let user = User(username: username)
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            self.ref.child("bank").child(accountType).child(String(self.accountNumber)).child("accountbalance").setValue(balance)
            
            let alert=UIAlertController(title: "Success", message: "Deposit Successful", preferredStyle: UIAlertController.Style.alert)
            let actionok=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionok)
            self.present(alert,animated: true,completion: nil)
            
        }
        
    }
    @IBAction func txtFetchButton(_ sender: Any) {
        if self.txtAccountNumber.text!.isEmpty{
            let alert=UIAlertController(title: "Error", message: "Enter Account Number", preferredStyle: UIAlertController.Style.alert)
            let actionok=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionok)
            self.present(alert,animated: true,completion: nil)
        }
        else{
            accountNumber = txtAccountNumber.text!
            let personId = txtAccountNumber.text!
            ref.child("customers").child(personId).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                var name = ""
                name = value?["name"] as? String ?? ""
                var contactNumber = ""
                contactNumber = value?["contactnumber"] as? String ?? ""
                DispatchQueue.main.async {
                    self.labelAccountHolder.text = "Account Holder : \(name)"
                    self.labelContactNumber.text = "Contact Number : \(contactNumber)"
                    if !self.labelAccountHolder.text!.isEmpty{
                        DispatchQueue.main.async {
                            self.btnDepositOutlet.isHidden = false
                            self.txtAmountToDeposit.isHidden = false
                        }
                    }
                    else{
                        self.btnDepositOutlet.isHidden = true
                        self.txtAmountToDeposit.isHidden = true
                        let alert=UIAlertController(title: "Error", message: "Account Does Not Exists", preferredStyle: UIAlertController.Style.alert)
                        let actionok=UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(actionok)
                        self.present(alert,animated: true,completion: nil)
                    }
                }
                
                //let user = User(username: username)
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
