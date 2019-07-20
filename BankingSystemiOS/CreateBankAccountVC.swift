//
//  AddUserViewController.swift
//  BankingSystemiOS
//
//  Created by Ashish on 2019-07-17.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class CreateBankAccountVC: UIViewController {
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    @IBOutlet weak var txtCustomerName: UITextField!
    @IBOutlet weak var txtCutomerAddress: UITextField!
    @IBOutlet weak var txtBirthDate: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtCustomerAccountBalance: UITextField!
    @IBOutlet weak var txtBankBranch: UITextField!
    @IBOutlet weak var txtPhotoAddressProofId: UITextField!
    var toolBar = UIToolbar()
    var picker  = UIDatePicker()
    var ref: DatabaseReference!
    var accountType: String = ""
    var personId: Int = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.isHidden = false;
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
        self.ref = Database.database().reference()
    }
    
    @IBAction func segmentAccountType(_ sender: UISegmentedControl) {
        switch SegmentedControl.selectedSegmentIndex{
        case 0:
            self.accountType="current"
        case 1:
            self.accountType="savings"
        default:
            break
        }
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    //------------
    //https://stackoverflow.com/questions/24552117/swift-using-uidatepicker-as-uitextfield-inputview-not-updating
    @IBAction func txtBirthDateOnClick(_ sender: UITextField) {
        picker = UIDatePicker()
        picker.datePickerMode = .date
        self.txtBirthDate.inputView = self.picker
        picker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        txtBirthDate.text = dateFormatter.string(from: sender.date)
    }
    //---------------
    @IBAction func btnCreateBankAccount(_ sender: Any) {
        
        self.personId = Int(arc4random())
        let fullName=txtCustomerName.text
        var flag: Bool = true
        if fullName!.isEmpty{
            flag = false
            let alert=UIAlertController(title: "Error", message: "customer Name Should Not be Empty", preferredStyle: .alert)
            let actionOk=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionOk)
            self.present(alert,animated: true,completion: nil)
        }
        let address=txtCutomerAddress.text
        if address!.isEmpty {
            flag = false
            let alert=UIAlertController(title: "Error", message: "Address is empty", preferredStyle: .alert)
            let actionOk=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionOk)
            self.present(alert,animated: true,completion: nil)
        }
        let birthDate=txtBirthDate.text
        if birthDate!.isEmpty{
            flag = false
            
            let alert=UIAlertController(title: "Error", message: "please Select Birthdate", preferredStyle: .alert)
            let actionOk=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionOk)
            self.present(alert,animated: true,completion: nil)
            
        }
        
        let contactNumber=txtContactNumber.text
        if contactNumber!.isEmpty {
            flag = false
            print("Phone Number Validation Failed! Try Again")
            let alert=UIAlertController(title: "Error", message: "Please Enter Valid ContactNumber", preferredStyle: UIAlertController.Style.alert)
            let actionok=UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(actionok)
            self.present(alert,animated: true,completion: nil)
            
        }
        let emailId=txtEmailId.text
        if emailId!.isEmpty{
            /*if(emailId!.isValidEmail()){
                self.ref.child("customers").child(String(personId)).child("emailid").setValue(txtEmailId.text)
            }
            else {*/
                flag = false
                print("Email Id Validation! Try Again")
                let alert=UIAlertController(title: "Error", message: "Please Enter EmailId", preferredStyle: UIAlertController.Style.alert)
                let actionok=UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(actionok)
                self.present(alert,animated: true,completion: nil)
        }
        let accountNumber: Int = Int(arc4random())
        
        if flag == true{
            self.ref.child("customers").child(String(personId)).child("name").setValue(fullName)
            self.ref.child("customers").child(String(personId)).child("address").setValue(address)
            self.ref.child("customers").child(String(personId)).child("birthdate").setValue(birthDate)
            self.ref.child("customers").child(String(personId)).child("emailid").setValue(txtEmailId.text)
            self.ref.child("customers").child(String(personId)).child("contactnumber").setValue(contactNumber)
            self.ref.child("bank").child(accountType).child(String(personId)).child("accountnumber").setValue(String(accountNumber))
            
            self.ref.child("bank").child(accountType).child(String(personId)).child("bankbranch").setValue(txtBankBranch.text)
            self.ref.child("bank").child(accountType).child(String(personId)).child("accountbalance").setValue(txtCustomerAccountBalance.text)
            self.ref.child("customers").child(String(personId)).child("photoaddressproofid").setValue(txtPhotoAddressProofId.text)
            
            self.performSegue(withIdentifier: "ViewUser", sender: self)
            
            
        }
    
    
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! UserInfoViewController
        vc.personId = String(self.personId)
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
