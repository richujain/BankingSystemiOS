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
    var accountNumber: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnTransferAmount.isHidden = true
        txtAmountToTransfer.isHidden = true
        // Do any additional setup after loading the view.
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
    

    @IBAction func btnFetch(_ sender: Any) {
        
    }
    @IBAction func btnTransferAmount(_ sender: Any) {
        
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
