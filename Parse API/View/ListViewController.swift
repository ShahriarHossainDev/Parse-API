//
//  ListViewController.swift
//  Parse API
//
//  Created by Shishir_Mac on 7/3/23.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APICaller.shared.getAllUser { result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                print(selectedTitle ?? "Ok")
                
            case .failure(let erorr):
                print(erorr.localizedDescription)
            }
        }
        // Do any additional setup after loading the view.
    }

}
