//
//  HomePageViewController.swift
//  TinyMarket
//
//  Created by Onur Sır on 08.04.2023.
//

import UIKit

class HomePageViewController: Builder {
 
        var itemList : [ItemListModel] = []
        @IBOutlet weak var collectionView: UICollectionView! {
            didSet {
                collectionView.register(UINib.init(nibName: "HomePageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomePageCollectionViewCell")
                collectionView.delegate = self
                collectionView.dataSource = self
                collectionView.allowsMultipleSelection = false
                collectionView.allowsSelection = true
                collectionView.showsVerticalScrollIndicator = false
                collectionView.showsHorizontalScrollIndicator = false
                collectionView.layer.cornerRadius = 0
                collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
        var viewModel : HomePageViewModel = {
            return HomePageViewModel()
        }()
        override func viewDidLoad() {
            super.viewDidLoad()
            startLoading()
            viewModel.delegate = self
            getRequest()
            // Do any additional setup after loading the view.
        }
        
        func             getRequest(){
            viewModel.getListReq()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            setupUI(isDetail: false)

            collectionView.reloadData()
        }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
            collectionView.reloadData()
            TotalConfig.shared.itemList.removeAll()
        }
    
        @objc override func tapRecognizer(_ sender: UITapGestureRecognizer? = nil) {
            let vc = BasketDetailViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.callback = {
                (item,newReq) in
                if newReq {
                    self.getRequest()
                } else {
                    guard let item = item else { return }
                    if let index = self.itemList.firstIndex(of: item) {
                        self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                    }
                    self.refresh()
                }
            }
        }
    }
    
    
    extension HomePageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return itemList.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionViewCell", for: indexPath) as? HomePageCollectionViewCell  else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            cell.configure(item: itemList[indexPath.row])
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            let collectionViewSize = collectionView.frame.size
            let itemWidth: CGFloat = (collectionViewSize.width-20)/3
            return CGSize.init(width: itemWidth, height: collectionViewSize.height*0.3 )
        }
    }
    
    extension HomePageViewController: HomePageVMMDelegate {
        func getErr(err: ErrorModel) {
            stopLoading()
            popupAlert(title: "Hata", message: err.description, actionTitles: ["Tamam"], actions: [{action1 in
                self.startLoading()
                self.getRequest()
            }])
        }
        
        func getListResponse(itemList: [ItemListModel]) {
            stopLoading()
            self.itemList = itemList
            self.collectionView.reloadData()
        }
        
    }
   
    

extension HomePageViewController: HomePageCollectionViewDelegate {
    func refreshBasket() {
        self.refresh()
    }
    
    
}



