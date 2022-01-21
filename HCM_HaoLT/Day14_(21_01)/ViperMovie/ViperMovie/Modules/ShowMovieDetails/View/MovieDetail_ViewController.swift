//
//  MOvieDetail_ViewController.swift
//  ViperMovie
//
//  Created by Hao Lam on 1/21/22.
//

import Foundation
import UIKit

class MovieDetail_ViewController : UIViewController {
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var bodyComment: UILabel!

    
    var presenter : (ViewToPresenter_MovieDetail_Protocol & InteractorToPresenter_MovieDetail_Protocol)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        presenter?.viewDidLoad()
        
    }
    func setupUI() {
        self.title = "Movie Comment"
        view.backgroundColor = UIColor.systemPink
        bodyComment.textColor = UIColor.white
        bodyComment.lineBreakMode = .byWordWrapping
        bodyComment.numberOfLines = 0
    }
}

extension MovieDetail_ViewController : PresenterToView_MovieDetail_Protocol {
    func onGetImageFromURL_Success() {
        //populate data to UI
        presenter?.populateDataIn(imgViewMovie: icon, lblDetail: bodyComment)

    }
    
    func onGetImageFromURL_Failure(error: String) {
    
    }
    
    func showActivity() {
        
    }
    
    func hideActivity() {
    
    }
    
    
}
