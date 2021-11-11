//
//  DetailtViewController.swift
//  swifty-demo
//
//  Created by Mavin on 10/11/21.
//

import UIKit

class DetailtViewController: UIViewController {

    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Title : ",article?.title ?? "")

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
