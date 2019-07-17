//
//  Person.swift
//  BankingSystemiOS
//
//  Created by Ashish on 2019-07-17.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import Foundation
class Person {
    var personId:String
    var personName:String
    var address:String
    var birthDate:String
    var contactNumber:String
    var emailId:String
    init(personId : String , personName : String , address : String , birthDate : String , contactNumber : String , emailId : String) {
        self.personId = String()
        self.personName = String()
        self.address = String()
        self.birthDate = String()
        self.contactNumber = String()
        self.emailId = String()
    }
}
/*
 //
 //  AddUserViewController.swift
 //  BankingSystemiOS
 //
 //  Created by Ashish on 2019-07-17.
 //  Copyright © 2019 Richu Jain. All rights reserved.
 //
 
 import UIKit
 
 class CreateBankAccountViewController: UIViewController {
 
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
 override func viewDidLoad() {
 super.viewDidLoad()
 
 // Do any additional setup after loading the view.
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

 */
