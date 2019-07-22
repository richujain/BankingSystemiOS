//
//  DepositViewController.swift
//  BankingSystemiOS
//
//  Created by Pat Abhishek on 2019-07-21.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit

class DepositViewController: UIViewController {
    @IBOutlet weak var txtAccountNumber: UITextField!
    @IBOutlet weak var labelAccountHolder: UILabel!
    @IBOutlet weak var btnDepositOutlet: UIButton!
    @IBOutlet weak var labelContactNumber: UILabel!
    @IBOutlet weak var txtAmountToDeposit: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnDepositOutlet.isHidden = true
        txtAmountToDeposit.isHidden = true
    }
    
    @IBAction func btnDepositButton(_ sender: Any) {
    }
    @IBAction func txtFetchButton(_ sender: Any) {
        
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
