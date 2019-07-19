//
//  ViewCustomerViewController.swift
//  BankingSystemiOS
//
//  Created by Ashish on 2019-07-18.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(personId)
        
        
        // Do any additional setup after loading the view.
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
