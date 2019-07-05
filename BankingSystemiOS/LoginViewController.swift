//
//  ViewController.swift
//  BankingSystemiOS
//
//  Created by Kiran Ramakrishnan Nair on 7/1/19.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet weak var emailEditText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordEditText: UITextField!
    //let homeNavigationController = UIViewController()
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
    }
    @IBAction func loginButtonAction(_ sender: UIButton) {
        let emailId: String = emailEditText.text!
        let password: String = passwordEditText.text!
        
        if !emailId.isEmpty && !password.isEmpty{
            
            Auth.auth().signIn(withEmail: emailId, password: password) { [weak self] user, error in
                guard self != nil else { return }
                // ...
                if let userID = Auth.auth().currentUser?.uid{
                    print("User ID is \(userID)")
                    if !userID.isEmpty{
                        let resultViewController = self!.storyBoard.instantiateViewController(withIdentifier: "homeSB") as! HomeViewController
                        self?.navigationController?.pushViewController(resultViewController, animated: true)
                    }
                }
                else{
                    print("Invalid Credentials")
                    let alert = UIAlertController(title: "Error", message: "Invalid Credentials", preferredStyle: .alert)
                    let dismiss = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(dismiss)
                    
                    self!.present(alert, animated: true, completion: nil)
                    
                }
                
            }
            
            
        }
        
        
    }
    
    
    
}

