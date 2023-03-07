//
//  PageViewController.swift
//  Parse API
//
//  Created by Shishir_Mac on 7/3/23.
//

import UIKit

class PageViewController: UIViewController {
    
    @IBOutlet weak var pageTableView: UITableView!
    
    private var titles: [User] = [User]()
    
    private let cellIdentifier: String = "userCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageTableView.delegate = self
        pageTableView.dataSource = self
        pageTableView.separatorStyle = .none
        
        self.pageTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        fetchPage()
        // Do any additional setup after loading the view.
    }
    
    
    private func fetchPage(){
        APICaller.shared.getPage(with: "2") { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.pageTableView.reloadData()
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension PageViewController: UITableViewDelegate, UITableViewDataSource {
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
