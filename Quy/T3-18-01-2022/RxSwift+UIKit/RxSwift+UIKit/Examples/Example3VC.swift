//
//  Example3VC.swift
//  RxSwift+UIKit
//
//  Created by Mcrew-Tech on 18/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

struct Images {
    let title: String
    let image: UIImage
}

class Example3VC: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [Images] = []
    let names = ["John","Mary","Hilda","Scott","Tom","Judie","Gon","Janet","Kyle"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make datasource
        if let image = UIImage(systemName: "person") {
            for name in names {
                let newImage = Images(title: name, image: image)
                data.append(newImage)
            }
        }

        registerCell()
        bindCollectionView()
        setLayout()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "Example3Cell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "Example3Cell")
    }
    
    private func bindCollectionView() {
        let observable = Observable.just(data)
        observable
            .bind(to: collectionView.rx.items(cellIdentifier: "Example3Cell", cellType: Example3Cell.self)){ index,model,cell in
                cell.config(model)
            }
            .disposed(by: disposeBag)
        
        //handling for tap
        collectionView.rx
            .modelSelected(Images.self)
            .subscribe(onNext: {images in
                print(images.title)
            })
            .disposed(by: disposeBag)
    }
    
    private func setLayout() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3,
                      height: collectionView.bounds.height / 3)
    }
}

