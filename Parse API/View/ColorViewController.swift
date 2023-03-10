//
//  ColorViewController.swift
//  Parse API
//
//  Created by Shishir_Mac on 10/3/23.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var colorTableView: UITableView!
    
    private var titles: [User] = [User]()
    
    private let cellIdentifier: String = "colorCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorTableView.delegate = self
        colorTableView.dataSource = self
        colorTableView.separatorStyle = .none
        
        self.colorTableView.register(UINib(nibName: "ColorTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        fetchColor()
        
    }
    
    private func fetchColor(){
        APICaller.shared.getAllColor { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.colorTableView.reloadData()
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ColorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ColorTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.configure(with: ColorViewModel(name: title.name ?? "", color: title.color ?? "", pantoneValue: title.pantoneValue ?? "" ))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
}
