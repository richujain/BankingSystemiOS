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
    
    @IBAction func txtBirthDateOnClick(_ sender: UITextField) {
        
    }
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
