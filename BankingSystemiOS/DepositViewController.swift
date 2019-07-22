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
    var transferRef: DatabaseReference!
    var isValidAccount: Bool = false
    var accountNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnDepositOutlet.isHidden = true
        txtAmountToDeposit.isHidden = true
        ref = Database.database().reference()
        transferRef = Database.database().reference()
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
            self.accountNumber = txtAccountNumber.text!
            let amountToDeposit: String = txtAmountToDeposit.text!
            var accountType: String = ""
            getAccountType(ref: ref, completionHandler: { (isFinished) in
                if isFinished {
                    print("Account Type is \(self.flag)")
                    if self.flag == 1{
                        accountType = "savings"
                    }
                    else{
                        accountType = "current"
                    }
                    var balance: String = "0.0"
                    print("Account Type is \(accountType)")
                    print("accountNumber is \(self.accountNumber)")
                    
                    self.ref.child("bank").child(accountType).child(self.accountNumber).observeSingleEvent(of: .value, with: { (snapshot) in
                        // Get user value
                        print("Snapshot is \(snapshot)")
                        if let value = snapshot.value as? NSDictionary{
                            balance = value["accountbalance"] as? String ?? ""
                            print("Balance is \(balance)")
                            print("Acc No is \(self.accountNumber)")
                            
                            let doubleBalance = Double(balance)
                            let doubleAmountToDeposit = Double(amountToDeposit)
                            let sum: Double = doubleBalance! + doubleAmountToDeposit!
                            self.ref.child("bank").child(accountType).child(String(self.accountNumber)).child("accountbalance").setValue(String(sum))
                        }
                        else{
                            let alert=UIAlertController(title: "Failed", message: "Deposit Failed", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                self.navigationController?.popViewController(animated: true)
                                return
                            }))
                            self.present(alert,animated: true,completion: nil)
                        }
                        
                        
                        
                        
                        
                        
                        //let user = User(username: username)
                        
                        // ...
                    }) { (error) in
                        print(error.localizedDescription)
                    }
                    
                    
                    let alert=UIAlertController(title: "Success", message: "Deposit Successful", preferredStyle: UIAlertController.Style.alert)
                    /*let actionok=UIAlertAction(title: "OK", style: .default, handler: nil)
                     alert.addAction(actionok)
                     self.present(alert,animated: true,completion: nil)*/
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                        return
                    }))
                    self.present(alert,animated: true,completion: nil)
                    
                }
            })
            
            
            
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
            txtAccountNumber.isUserInteractionEnabled = false
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
