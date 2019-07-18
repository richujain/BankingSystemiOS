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
    
    @IBOutlet weak var txtCustomerName: UITextField!
    @IBOutlet weak var txtCutomerAddress: UITextField!
    @IBOutlet weak var txtBirthDate: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtAccountType: UITextField!
    @IBOutlet weak var txtCustomerAccountBalance: UITextField!
    @IBOutlet weak var txtBankBranch: UITextField!
    @IBOutlet weak var txtPhotoAddressProofId: UITextField!
    var toolBar = UIToolbar()
    var picker  = UIDatePicker()
    var ref: DatabaseReference!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.isHidden = false;
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
        self.ref = Database.database().reference()
        
        
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
        //let personId: Int = arc4random()
        self.ref.child("customers").child("456").child("address").setValue(txtCutomerAddress.text)
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
