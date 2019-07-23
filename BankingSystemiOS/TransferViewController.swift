//
//  TransferViewController.swift
//  BankingSystemiOS
//
//  Created by Pat Abhishek on 2019-07-22.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TransferViewController: UIViewController {

    @IBOutlet weak var txtBeneficiaryAccountNumber: UITextField!
    @IBOutlet weak var txtRemitterAccountNumber: UITextField!
    @IBOutlet weak var labelRemitterName: UILabel!
    @IBOutlet weak var txtAmountToTransfer: UITextField!
    @IBOutlet weak var btnTransferAmount: UIButton!
    @IBOutlet weak var labelBeneficiaryContactNumber: UILabel!
    @IBOutlet weak var labelBeneficiaryName: UILabel!
    @IBOutlet weak var labelRemitterContactNumber: UILabel!
    typealias completion = (_ isFinished:Bool) -> Void
    var flag:Int = 0
    var ref: DatabaseReference!
    var isValidAccount: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnTransferAmount.isHidden = true
        txtAmountToTransfer.isHidden = true
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }
    func getAccountType(accountNumber: String, ref: DatabaseReference, completionHandler: @escaping completion) {
        flag = 0
        
        ref.child("bank").child("savings").child(accountNumber).observeSingleEvent(of: .value, with: { (snapshot) in
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
        
        ref.child("bank").child("current").child(accountNumber).observeSingleEvent(of: .value, with: { (snapshot) in
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
    

    @IBAction func btnFetch(_ sender: Any) {
        if self.txtRemitterAccountNumber.text!.isEmpty{
            let alert=UIAlertController(title: "Error", message: "Enter Remitter Account Number", preferredStyle: UIAlertController.Style.alert)
            let actionok=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionok)
            self.present(alert,animated: true,completion: nil)
        }else if self.txtBeneficiaryAccountNumber.text!.isEmpty{
            let alert=UIAlertController(title: "Error", message: "Enter Beneficiary Account Number", preferredStyle: UIAlertController.Style.alert)
            let actionok=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionok)
            self.present(alert,animated: true,completion: nil)
        }
        else{
            txtRemitterAccountNumber.isUserInteractionEnabled = false
            txtBeneficiaryAccountNumber.isUserInteractionEnabled = false
            //var accountNumber = txtRemitterAccountNumber.text!
            //----------------------------
            var personId = txtRemitterAccountNumber.text!
            ref.child("customers").child(personId).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                var remitterName = ""
                remitterName = value?["name"] as? String ?? ""
                var remitterContactNumber = ""
                remitterContactNumber = value?["contactnumber"] as? String ?? ""
                DispatchQueue.main.async {
                    self.labelRemitterName.text = "Remitter Account Holder : \(remitterName)"
                    self.labelRemitterContactNumber.text = "Remitter Contact Number : \(remitterContactNumber)"
                    if !self.labelRemitterName.text!.isEmpty{
                        DispatchQueue.main.async {
                            self.btnTransferAmount.isHidden = false
                            self.txtAmountToTransfer.isHidden = false
                        }
                    }
                    else{
                        self.btnTransferAmount.isHidden = true
                        self.txtAmountToTransfer.isHidden = true
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
            //-------
           
            personId = txtBeneficiaryAccountNumber.text!
            ref.child("customers").child(personId).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                var beneficiaryName = ""
                beneficiaryName = value?["name"] as? String ?? ""
                var beneficiaryContactNumber = ""
                beneficiaryContactNumber = value?["contactnumber"] as? String ?? ""
                DispatchQueue.main.async {
                    self.labelBeneficiaryName.text = "Beneficiary Account Holder : \(beneficiaryName)"
                    self.labelBeneficiaryContactNumber.text = "Beneficiary Contact Number : \(beneficiaryContactNumber)"
                    if !self.labelBeneficiaryName.text!.isEmpty{
                        DispatchQueue.main.async {
                            self.btnTransferAmount.isHidden = false
                            self.txtAmountToTransfer.isHidden = false
                        }
                    }
                    else{
                        self.btnTransferAmount.isHidden = true
                        self.txtAmountToTransfer.isHidden = true
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
    @IBAction func btnTransferAmount(_ sender: Any) {
        if txtAmountToTransfer.text!.isEmpty{
            let alert=UIAlertController(title: "Error", message: "Enter Amount to Deposit", preferredStyle: UIAlertController.Style.alert)
            let actionok=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionok)
            self.present(alert,animated: true,completion: nil)
        }
        else{
            
            
            
            
            
            let remitterAccountNumber = txtRemitterAccountNumber.text!
            let beneficiaryAccountNumber = txtBeneficiaryAccountNumber.text!
            let amountToTransfer: String = txtAmountToTransfer.text!
            //withdrawl
            var accountType: String = ""
            getAccountType(accountNumber: remitterAccountNumber, ref: ref, completionHandler: { (isFinished) in
                if isFinished {
                    print("Account Type is \(self.flag)")
                    if self.flag == 1{
                        accountType = "savings"
                    }
                    else{
                        accountType = "current"
                    }
                    var balance: String = "0.0"
                    self.ref.child("bank").child(accountType).child(remitterAccountNumber).observeSingleEvent(of: .value, with: { (snapshot) in
                        // Get user value
                        let value = snapshot.value as? NSDictionary
                        balance = value?["accountbalance"] as? String ?? ""
                        let doubleBalance = Double(balance)
                        let doubleAmountToDeposit = Double(amountToTransfer)
                        let sum: Double = doubleBalance! - doubleAmountToDeposit!
                        print("sum is \(sum)")
self.ref.child("bank").child(accountType).child(String(remitterAccountNumber)).child("accountbalance").setValue(String(sum))
                        
                        
                        
                        //let user = User(username: username)
                        
                        // ...
                    }) { (error) in
                        print(error.localizedDescription)
                    }
                    
                }
            })
            
            
            //deposit
            getAccountType(accountNumber: beneficiaryAccountNumber, ref: ref, completionHandler: { (isFinished) in
                if isFinished {
                    print("Account Type is \(self.flag)")
                    var accountType = ""
                    if self.flag == 1{
                        accountType = "savings"
                    }
                    else{
                        accountType = "current"
                    }
                    var balance: String = "0.0"
                    self.ref.child("bank").child(accountType).child(beneficiaryAccountNumber).observeSingleEvent(of: .value, with: { (snapshot) in
                        // Get user value
                        let value = snapshot.value as? NSDictionary
                        balance = value?["accountbalance"] as? String ?? ""
                        let doubleBalance = Double(balance)
                        let doubleAmountToDeposit = Double(amountToTransfer)
                        let sum: Double = doubleBalance! + doubleAmountToDeposit!
                        
                        self.ref.child("bank").child(accountType).child(String(beneficiaryAccountNumber)).child("accountbalance").setValue(String(sum))
                        
                        
                        
                        //let user = User(username: username)
                        
                        // ...
                    }) { (error) in
                        print(error.localizedDescription)
                    }
                }
            })
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
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
