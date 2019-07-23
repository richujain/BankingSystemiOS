//
//  ViewController.swift
//  BankingSystemiOS
//
//  Created by Kiran Ramakrishnan Nair on 7/1/19.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit
import FirebaseAuth
import MessageUI

class LoginViewController: UIViewController, UITextFieldDelegate, MFMessageComposeViewControllerDelegate {
    
    
    @IBOutlet weak var labelInstructions: UILabel!
    @IBOutlet weak var emailEditText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordEditText: UITextField!
    @IBOutlet weak var switchRememberMe: UISwitch!
    var overlay : UIView? // This should be a class variable
    //let homeNavigationController = UIViewController()
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //self.navigationController!.navigationBar.isHidden = true;
        self.emailEditText.delegate = self
        self.passwordEditText.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        if Auth.auth().currentUser != nil {
            presentHome()
        }
    }
    func presentHome() {
        self.performSegue(withIdentifier: "EmployeeHomeSB", sender: self)
    }
    
    
    
    
    @IBAction func btnContact(_ sender: Any) {
        if let url = URL(string: "tel://+14372391989)"), UIApplication.shared.canOpenURL(url){
            if #available(iOS 10, *)
            {
                UIApplication.shared.open(url)
            }
            else
            {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @IBAction func btnSMS(_ sender: Any) {
        if MFMessageComposeViewController.canSendText() {
            
            
            let messageVC = MFMessageComposeViewController()
            
            messageVC.body = "Hello"
            messageVC.recipients = ["+14372391989"]
            messageVC.messageComposeDelegate = self
            
            self.present(messageVC, animated: false, completion: nil)
        }
        else{
            print("NO SIM available")
        }
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnInstructions(_ sender: UIButton) {
        let resultViewController = self.storyBoard.instantiateViewController(withIdentifier: "InstructionsVC") as! InstructionsViewController
        self.navigationController?.pushViewController(resultViewController, animated: true)
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func loginCheck() {
        //---
        overlay = UIView(frame: view.frame)
        overlay!.backgroundColor = UIColor.black
        overlay!.alpha = 0.8
        
        view.addSubview(overlay!)
        //---
        let emailId: String = emailEditText.text!
        let password: String = passwordEditText.text!
        
        if !emailId.isEmpty && !password.isEmpty{
            
            Auth.auth().signIn(withEmail: emailId, password: password) { [weak self] user, error in
                guard self != nil else { return }
                // ...
                if let userID = Auth.auth().currentUser?.uid{
                    print("User ID is \(userID)")
                    if !userID.isEmpty{
                        /*self!.overlay?.removeFromSuperview()
                        let resultViewController = self!.storyBoard.instantiateViewController(withIdentifier: "EmployeeHomeSB") as! EmployeeHomeTVC
                        self?.navigationController?.pushViewController(resultViewController, animated: true)*/
                        
                        self?.performSegue(withIdentifier: "EmployeeHomeSB", sender: self)
                    }
                }
                else{
                    self!.overlay?.removeFromSuperview()
                    let alert = UIAlertController(title: "Error", message: "Invalid Credentials", preferredStyle: .alert)
                    let dismiss = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(dismiss)
                    
                    self!.present(alert, animated: true, completion: nil)
                    
                }
                
            }
            
            
        }
        else{
            print("Empty Fields")
            self.overlay?.removeFromSuperview()
            let alertifEmpty = UIAlertController(title: "Error", message: "Fields cannot be empty", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alertifEmpty.addAction(dismiss)
            
            self.present(alertifEmpty, animated: true, completion: nil)
        }
    }
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //textField code
        print("Pressed")
        emailEditText.resignFirstResponder()
        if passwordEditText.resignFirstResponder(){
            loginCheck()
        }        
        
        return true
    }
    @IBAction func loginButtonAction(_ sender: UIButton) {
        
        loginCheck()
        let userDefault=UserDefaults.standard
        if switchRememberMe.isOn{
            if switchRememberMe.isOn{
                
                userDefault.set(passwordEditText.text, forKey: "password")
                userDefault.set(emailEditText.text, forKey: "user")
            }
            else{
                userDefault.removeObject(forKey: "password")
                userDefault.removeObject(forKey: "user")
            }

            
        }
        
    }
    
    private func getRememberMeValues()
    {
        let userDefault = UserDefaults.standard
        
        if let email = userDefault.string(forKey: "userEmail")
        {
            emailEditText.text = email
            
            if let pwd = userDefault.string(forKey: "userPassword")
            {
                passwordEditText.text = pwd
            }
        }
    }
    
    
    
}

