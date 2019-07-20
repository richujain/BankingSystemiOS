//
//  ViewCustomerViewController.swift
//  BankingSystemiOS
//
//  Created by Ashish on 2019-07-18.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UserInfoViewController: UIViewController {
   
    @IBOutlet weak var txtCustomerName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtBirthDate: UITextField!
    @IBOutlet weak var lblAccountType: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var txtPhotoAddressIdProof: UITextField!
    @IBOutlet weak var txtBankBranch: UITextField!
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var personId: String = ""
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.ref.child("customers").child(self.personId).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let customerName = value?["name"] as? String ?? ""
            let address = value?["address"] as? String ?? ""
            let emailId = value?["emailid"] as? String ?? ""
            let birthDate = value?["birthdate"] as? String ?? ""
            let photoAddressProofId = value?["photoaddressproofid"] as? String ?? ""
            let contactNumber = value?["contactnumber"] as? String ?? ""

            self.txtCustomerName.text = customerName
            self.txtAddress.text = address
            self.txtContactNumber.text = contactNumber
            self.txtEmailId.text = emailId
            self.txtBirthDate.text = birthDate
            self.txtPhotoAddressIdProof.text = birthDate

            
            //let user = User(username: username)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        print("Account Type is \(getAccountType(ref: ref))")
        
        
        
        // Do any additional setup after loading the view.
    }
    func getAccountType(ref: DatabaseReference) -> String {
        print("Person ID is \(self.personId)")
        ref.child("bank").child("savings").child(personId).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            return "savings"
            
            //let user = User(username: username)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        ref.child("bank").child("savings").child(personId).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            return "current"
            
            //let user = User(username: username)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        return "null"
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
