//
//  HomeViewController.swift
//  BankingSystemiOS
//
//  Created by Ashish on 2019-07-04.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    @IBOutlet weak var logoutButton: UIButton!
    //let newViewController = LoginViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Reached Home Controller")
        
        
    }
    @IBAction func logoutButtonAction(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            //self.navigationController?.pushViewController(self.newViewController, animated: true)
            //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            dismissViewControllers()
            self.navigationController?.popToRootViewController(animated: true)

        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    func dismissViewControllers() {
        
        guard let vc = self.presentingViewController else { return }
        
        while (vc.presentingViewController != nil) {
            vc.dismiss(animated: true, completion: nil)
        }
    }
    
}
