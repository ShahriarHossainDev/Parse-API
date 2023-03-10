//
//  PageViewController.swift
//  Parse API
//
//  Created by Shishir_Mac on 7/3/23.
//

import UIKit

class PageViewController: UIViewController {
    
    @IBOutlet weak var pageSearchBar: UISearchBar!
    @IBOutlet weak var pageTableView: UITableView!
    
    private var titles: [User] = [User]()
    
    private let cellIdentifier: String = "userCell"
    
    var searchedPage = String()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageTableView.delegate = self
        pageTableView.dataSource = self
        pageTableView.separatorStyle = .none
        
        self.pageTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        fetchPage(nu: "1")
        pageSearchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    private func fetchPage(nu: String){
        APICaller.shared.getPage(with: nu) { [weak self] result in
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


extension PageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedPage = pageSearchBar.text ?? ""
        if searchedPage == "" {
            fetchPage(nu: "1")
        } else {
            fetchPage(nu: searchedPage)
        }
    }
}

extension PageViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //let searchBar = searchController.searchBar
        
        guard let query = pageSearchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 1 else { return }
        
        fetchPage(nu: query)
        
    }
}
