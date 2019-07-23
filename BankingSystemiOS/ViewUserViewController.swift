//
//  ViewUserViewController.swift
//  BankingSystemiOS
//
//  Created by Pat Abhishek on 2019-07-22.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewUserViewController: UIViewController {

    @IBOutlet weak var txtAccountNumber: UITextField!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelBirthDate: UILabel!
    @IBOutlet weak var labelEmailID: UILabel!
    @IBOutlet weak var labelIdProofNumber: UILabel!
    @IBOutlet weak var labelBalance: UILabel!
    @IBOutlet weak var labelBankBranch: UILabel!
    @IBOutlet weak var labelContactNumber: UILabel!
    typealias completion = (_ isFinished:Bool) -> Void
    var flag:Int = 0
    var ref: DatabaseReference!
    var isValidAccount: Bool = false
    var accountNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
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
    @IBAction func btnFetch(_ sender: UIButton) {
        
        
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
                var address = ""
                var contactNumber = ""
                var birthDate = ""
                var emailId = ""
                var photoAddressId = ""
                
                name = value?["name"] as? String ?? ""
                contactNumber = value?["contactnumber"] as? String ?? ""
                photoAddressId = value?["photoaddressproofid"] as? String ?? ""
                birthDate = value?["birthdate"] as? String ?? ""
                emailId = value?["emailid"] as? String ?? ""
                address = value?["address"] as? String ?? ""
                
                DispatchQueue.main.async {
                    self.labelName.text = "Account Holder : \(name)"
                    self.labelContactNumber.text = "Contact Number : \(contactNumber)"
                    self.labelAddress.text = "Address : \(address)"
                    self.labelBirthDate.text = "Birth Date : \(birthDate)"
                    self.labelIdProofNumber.text = "ID Proof Number : \(photoAddressId)"
                    self.labelEmailID.text = "Email ID : \(emailId)"
                    
                    if !self.labelName.text!.isEmpty{
                        DispatchQueue.main.async {
                            //self.btnDone.isHidden = false
                        }
                    }
                    else{
                        //self.btnDone.isHidden = true
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
                self.ref.child("bank").child(accountType).child(personId).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                var balance = ""
                var bankBranch = ""
                balance = value?["accountbalance"] as? String ?? ""
                bankBranch = value?["bankbranch"] as? String ?? ""
                
                DispatchQueue.main.async {
                    self.labelBalance.text = "Balance : \(balance)"
                    self.labelBankBranch.text = "Bank Branch : \(bankBranch)"
                    
                    /*if !self.labelName.text!.isEmpty{
                        DispatchQueue.main.async {
                            self.btnDone.isHidden = false
                        }
                    }
                    else{
                        self.btnDone.isHidden = true
                        let alert=UIAlertController(title: "Error", message: "Account Does Not Exists", preferredStyle: UIAlertController.Style.alert)
                        let actionok=UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(actionok)
                        self.present(alert,animated: true,completion: nil)
                    }*/
                }
                
                
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
