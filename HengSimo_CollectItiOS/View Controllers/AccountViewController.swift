//
//  AccountViewController.swift
//  HengSimo_CollectItiOS
//
//  Created by HENG on 12/12/2019.
//  Copyright © 2019 HENG. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendCloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func senLogoutButton(_ sender: UIButton) {
        try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
}
