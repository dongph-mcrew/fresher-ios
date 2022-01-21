//
//  MovieList_ViewController.swift
//  ViperMovie
//
//  Created by Hao Lam on 1/20/22.
//

import UIKit


class MovieList_ViewController : UIViewController{
    let tableview: UITableView = {
            let tv = UITableView()
            tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            tv.backgroundColor = UIColor.systemMint
            tv.translatesAutoresizingMaskIntoConstraints = false
            return tv
        }()
    
    var presenter : (ViewToPresenter_MovieList_Protocol & InteractorToPresenter_MovieList_Protocol)?
    
    
    override func viewDidLoad() {
        setupUI()
        //pass VC to presenter to make decision
        presenter?.viewDidLoad()
    }
    
    func setupUI() {
        self.title = "Movie Sample Using Viper"
     

        tableview.delegate = self
        tableview.dataSource = self
        
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
  
    
}

extension MovieList_ViewController : PresenterToView_MovieList_Protocol {
    func onFetch_MovieList_Success() {
        //when sucess, reload table
        print("Got posts")
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
        
    }
    
    func onFetch_MovieList_Failure(error : String) {
        //handling error
        print(error)
    }
    
    func showActivity() {
        //show indicator
        //Utility.showsActivityIndicator(on: self.view)
    }
    
    func hideActiviy() {
        //hide indicator
        //Utility.hideIndicator(on: self.view)

    }
    
}

extension MovieList_ViewController :  UITableViewDelegate,  UITableViewDataSource {
    
    ///**NOTE: we are not taking any decision here ! We are passing the decision to Presenter **
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // 1
        return presenter?.numberOfRowsInSection() ?? 0
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        return presenter?.setCell(tableView: tableView, forRowAt: indexPath) ?? UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         presenter?.didSelectRowAt(index: indexPath.row)
    }
    
}
