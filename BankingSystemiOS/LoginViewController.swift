//
//  ViewController.swift
//  BankingSystemiOS
//
//  Created by Kiran Ramakrishnan Nair on 7/1/19.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailEditText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordEditText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
    }
    @IBAction func loginButtonAction(_ sender: UIButton) {
        let emailId: String = emailEditText.text!
        let password: String = passwordEditText.text!
        if !emailId.isEmpty && !password.isEmpty{
            print(emailId)
            print(password)
        }
        
        
    }
    
}

