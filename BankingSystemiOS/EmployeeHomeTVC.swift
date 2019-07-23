//
//  EmployeeHomeVCTableViewController.swift
//  BankingSystemiOS
//
//  Created by Kiran Ramakrishnan Nair on 7/9/19.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit
import FirebaseAuth

class EmployeeHomeTVC: UITableViewController {

    @IBOutlet var employeeActivities: UITableView!
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController!.navigationBar.isHidden = true;

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return 2
        }
        else if section == 1{
            return 3
        }
        else{
            return 1
        }
    }
    func dismissViewControllers() {
        
        guard let vc = self.presentingViewController else { return }
        
        while (vc.presentingViewController != nil) {
            vc.dismiss(animated: true, completion: nil)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0{
            let resultViewController = self.storyBoard.instantiateViewController(withIdentifier: "CreateAccountSB") as! CreateBankAccountVC
            self.navigationController?.pushViewController(resultViewController, animated: true)
        }
        else if indexPath.section == 0 && indexPath.row == 1 {
            let resultViewController = self.storyBoard.instantiateViewController(withIdentifier: "ViewUser") as! ViewUserViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
            
        }else if indexPath.section == 1 && indexPath.row == 0 {
            let resultViewController = self.storyBoard.instantiateViewController(withIdentifier: "DepositVC") as! DepositViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
            
        }else if indexPath.section == 1 && indexPath.row == 1 {
            let resultViewController = self.storyBoard.instantiateViewController(withIdentifier: "WithdrawlVC") as! WithdrawlViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
            
        }else if indexPath.section == 1 && indexPath.row == 2 {
            let resultViewController = self.storyBoard.instantiateViewController(withIdentifier: "TransferVC") as! TransferViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
            
        }else if indexPath.section == 2 && indexPath.row == 0{
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                //self.navigationController?.pushViewController(self.newViewController, animated: true)
                //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                dismissViewControllers()
                //self.navigationController?.popToRootViewController(animated: true)
                
                self.performSegue(withIdentifier: "EmployeeToLogin", sender: self)
                
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
