//
//  View.swift
//  VIPER Architecture
//
//  Created by Hao Lam on 1/20/22.
//

import Foundation
import UIKit

// - View is responsible for user interface
// - You can have a ViewController to be the View as a part of the architecture
//      + We would need a Protocol to outline what the ViewController object should have on it
// - We also need a reference of a view to Presenter

protocol AnyView {
    // reference to presenter
    var presenter : AnyPresenter? {get set }
    
    //functions
    func update(with user: [User])
    func update(with error: String)
}

class UserViewController : UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource{
  
    var presenter: AnyPresenter?
    
    var tableView : UITableView =  {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = false
        return table
    }()
    
    var users : [User] = []
    
    private let label : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .systemPink
        view.addSubview(tableView)
        view.addSubview(label)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
        
    }
 
    func update(with user: [User]) {
        print("Got users")
        print(user)
        DispatchQueue.main.async {
            self.users = user
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.users = []
            self.label.text = error
            self.tableView.isHidden = true
            self.label.isHidden = false
        }
    }
    
    //table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        
        return cell
    }
    
    
    
}
