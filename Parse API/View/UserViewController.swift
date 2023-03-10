//
//  UserViewController.swift
//  Parse API
//
//  Created by Shishir_Mac on 7/3/23.
//

import UIKit

class UserViewController: UIViewController {
    let parameters = "{\n    \"name\": \"shishir\",\n    \"job\": \"ios developer\"\n}"
    
    //private var titles: [CreateUser] = [CreateUser]()
    
    @IBOutlet weak var createUserView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUserView.layer.cornerRadius = 10
        createUserView.dropShadow()
        
        messageLabel.text = ""
        
        fetchCreateUser(nu: parameters)

        // Do any additional setup after loading the view.
    }
    
    private func fetchCreateUser(nu: String){
        APICaller.shared.createUser(with: parameters) { result in
        
        }
        
    }

    @IBAction func createButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func updateButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        
    }
    
}
