//
//  ListViewController.swift
//  Parse API
//
//  Created by Shishir_Mac on 7/3/23.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var userTableView: UITableView!
    
    private var titles: [User] = [User]()
    
    private let cellIdentifier: String = "userCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.separatorStyle = .none
        
        self.userTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        fetchUpcoming()
        // Do any additional setup after loading the view.
    }
    
    
    private func fetchUpcoming(){
        APICaller.shared.getAllUser { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.userTableView.reloadData()
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.configure(with: UserViewModel(firstName: title.first_name ?? "", lastName: title.last_name ?? "", email: title.email ?? "", avatarURL: title.avatar ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
