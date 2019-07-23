//
//  InstructionsViewController.swift
//  BankingSystemiOS
//
//  Created by Pat Abhishek on 2019-07-22.
//  Copyright © 2019 Richu Jain. All rights reserved.
//

import UIKit
import WebKit

class InstructionsViewController: UIViewController {
//    @IBOutlet weak var webViewInstructions: WKWebView!
//    @IBOutlet weak var webviewInstructions: UIWebView!
    
    @IBOutlet weak var webviewInstructions: WKWebView!
    override func viewDidLoad() {
      
        
        let indexPaths = NSURL(string: "http://prometheusbox.com/index2.html");
        
        let requestObj = NSURLRequest(url: indexPaths! as URL);
        webviewInstructions.load(requestObj as URLRequest);

     
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
