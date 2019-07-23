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
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var labelContactNumber: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDone.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnFetch(_ sender: UIButton) {
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
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
