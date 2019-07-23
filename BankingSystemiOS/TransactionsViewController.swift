
//
//  TransactionsViewController.swift
//  BankingSystemiOS
//
//  Created by Ashish on 2019-07-22.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit
import FirebaseDatabase
//https://stackoverflow.com/questions/46545468/swift-firebase-retrieve-data-into-tableview
class Transactions {
    
    var remitter: String?
    var beneficiary: String?
    var amount: String?
    var datetime: String?
    init(remitter: String?, beneficiary: String?,amount: String?,datetime: String?) {
        self.remitter = remitter
        self.beneficiary = beneficiary
        self.amount = amount
        self.datetime = datetime
    }
}
class TransactionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var btnFetch: UIButton!
    @IBOutlet weak var tblTransactions: UITableView!
    //typealias completion = (_ isFinished:Bool) -> Void
    //var flag:Int = 0
    var ref: DatabaseReference!
    var secondRef: DatabaseReference!

    @IBOutlet weak var txtAccountNumber: UITextField!
    var myTransactions = [Transactions]()
    var accountNumber: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblTransactions.dataSource = self
        tblTransactions.delegate = self
        ref = Database.database().reference()
        secondRef = Database.database().reference()
        tblTransactions.isHidden = true
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath)
        
        let test = myTransactions[indexPath.row]
        var statement: String = ""
        //code
        statement = ""
        if test.remitter == "cash" && test.beneficiary == accountNumber{
            statement = "$ \(test.amount!) deposited on \(test.datetime!)"
        }
        else if test.beneficiary == "cash" && test.remitter == accountNumber{
            statement = "$ \(test.amount!) withdrawed on \(test.datetime!)"

        }
        else if test.remitter == accountNumber{
            statement = "$ \(test.amount!) transferred from your account to \(test.beneficiary!) on \(test.datetime!)"
        }
        else if test.beneficiary == accountNumber{
            statement = "$ \(test.amount!) transferred to your account from \(test.remitter!) on \(test.datetime!)"
        }
       
        
        
        cell.textLabel!.numberOfLines = 0
        //cell.textLabel!.lineBreakMode = UILineBreakModeWordWrap
        
        //end of code
        if !statement.isEmpty{
            cell.textLabel?.text = statement
        }
        return cell
    }
    

    
    @IBAction func btnFetch(_ sender: Any) {
        myTransactions.removeAll()
        DispatchQueue.main.async {
            self.tblTransactions.reloadData()
        }
        if self.txtAccountNumber.text!.isEmpty{
            let alert=UIAlertController(title: "Error", message: "Enter Account Number", preferredStyle: UIAlertController.Style.alert)
            let actionok=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionok)
            self.present(alert,animated: true,completion: nil)
        }else{
            tblTransactions.isHidden = false
            btnFetch.isHidden = true
            accountNumber = txtAccountNumber.text!
            //ref.child("transactions").child(accountNumber).observeSingleEvent(of: .value, with: { (snapshot) in
            ref.child("transactions").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                //print(snapshot.childrenCount)
                
                if let snap = snapshot.value as? [String:Any] {
                    
                    for key in snap.keys{
                        self.secondRef.child("transactions").child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                            let value = snapshot.value as? NSDictionary
                            var amount = ""
                            var beneficiary = ""
                            var remitter = ""
                            var datetime = ""
                            remitter = value?["remitter"] as? String ?? ""
                            beneficiary = value?["beneficiary"] as? String ?? ""
                            datetime = value?["datetime"] as? String ?? ""
                            amount = value?["amount"] as? String ?? ""
                            if remitter == self.accountNumber || beneficiary == self.accountNumber{
                                let myTransaction = Transactions(remitter: remitter, beneficiary: beneficiary, amount: amount, datetime: datetime)
                                self.myTransactions.append(myTransaction)
                            }
                            DispatchQueue.main.async {
                                self.tblTransactions.reloadData()
                            }
                        })
                        { (error) in
                            print(error.localizedDescription)
                        }
                    }
                    
                }
            })
            { (error) in
                print(error.localizedDescription)
            }
        }
        /*
        ref.child("transactions").child(personId).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            var amount = ""
            var beneficiary = ""
            var remitter = ""
            var datetime = ""
            remitter = value?["remitter"] as? String ?? ""
            beneficiary = value?["beneficiary"] as? String ?? ""
            datetime = value?["datetime"] as? String ?? ""
            amount = value?["amount"] as? String ?? ""
            DispatchQueue.main.async {
                self.labelAccountHolder.text = "Account Holder : \(name)"
                self.labelContactNumber.text = "Contact Number : \(contactNumber)"
                if !self.labelAccountHolder.text!.isEmpty{
                    self.btnDepositOutlet.isHidden = false
                    self.txtAmountToDeposit.isHidden = false
                }
                else{
                    
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
        }*/
    
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
