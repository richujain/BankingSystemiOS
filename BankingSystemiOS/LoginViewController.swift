//
//  ViewController.swift
//  BankingSystemiOS
//
//  Created by Kiran Ramakrishnan Nair on 7/1/19.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailEditText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordEditText: UITextField!
    //let homeNavigationController = UIViewController()
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController!.navigationBar.isHidden = true;
        self.passwordEditText.delegate = self
        self.emailEditText.delegate = self
        
    }
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //textField code
        
        textField.resignFirstResponder()  //if desired
        loginCheck()
        return true
    }
    func loginCheck() {
        let emailId: String = emailEditText.text!
        let password: String = passwordEditText.text!
        
        if !emailId.isEmpty && !password.isEmpty{
            
            Auth.auth().signIn(withEmail: emailId, password: password) { [weak self] user, error in
                guard self != nil else { return }
                // ...
                if let userID = Auth.auth().currentUser?.uid{
                    print("User ID is \(userID)")
                    if !userID.isEmpty{
                        let resultViewController = self!.storyBoard.instantiateViewController(withIdentifier: "homeSB") as! EmployeeHomeViewController
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
    @IBAction func loginButtonAction(_ sender: UIButton) {
        
        loginCheck()
        
    }
    
    
    
}

