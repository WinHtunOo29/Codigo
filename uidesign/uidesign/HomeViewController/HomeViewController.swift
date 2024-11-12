//
//  HomeViewController.swift
//  uidesign
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var inhabitantsView: UIView!
    @IBOutlet weak var showsView: UIView!
    @IBOutlet weak var shoppingView: UIView!
    @IBOutlet weak var dineView: UIView!
    @IBOutlet weak var meetsView: UIView!
    @IBOutlet weak var ticketsView: UIView!
    @IBOutlet weak var parkView: UIView!
    @IBOutlet weak var showsCollectionView: UICollectionView!
    
    var timer = Timer()
    let page = 3
    let displayCountPerRow: CGFloat = 1
    let bannerMinimumInteritemSpacing: CGFloat = 0
    let showMinimumInteritemSpacing: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIs()
        setUpBannerCollectionView()
        setUpShowsCollectionView()
    }
    
    private func setupUIs() {
        mapView.makeCircular()
        inhabitantsView.makeCircular()
        showsView.makeCircular()
        shoppingView.makeCircular()
        dineView.makeCircular()
        meetsView.makeCircular()
        
        ticketsView.makeRoundedCornerWithShadow(offSet: CGSize(width: -4, height: 4))
        parkView.makeRoundedCornerWithShadow(offSet: CGSize(width: -4, height: 4))
    }
    
    private func setUpBannerCollectionView() {
        if let layout = bannerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        bannerCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
        
        let proxy = UIPageControl.appearance()
        proxy.pageIndicatorTintColor = .lightGray
        proxy.currentPageIndicatorTintColor = .red
        proxy.backgroundColor = .clear
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }
    
    private func setUpShowsCollectionView() {
        if let layout = showsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        showsCollectionView.delegate = self
        showsCollectionView.dataSource = self
        showsCollectionView.register(UINib(nibName: "ShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ShowCollectionViewCell")
    }
    
    @objc func moveToNextPage (){
        let pageWidth:CGFloat = self.bannerCollectionView.frame.width
        let maxWidth:CGFloat = pageWidth * CGFloat((page))
        let contentOffset:CGFloat = self.bannerCollectionView.contentOffset.x

        var slideToX = contentOffset + pageWidth

        if  contentOffset + pageWidth == maxWidth {
                slideToX = 0
        }

        self.bannerCollectionView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.bannerCollectionView.frame.height), animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowCollectionViewCell", for: indexPath) as? ShowCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollectionView {
            let contentInset: UIEdgeInsets = collectionView.contentInset
            
            let cellWidth: CGFloat = (
                (collectionView.frame.width - (contentInset.left + contentInset.right)
                 - (bannerMinimumInteritemSpacing * (displayCountPerRow - 1)))
                / displayCountPerRow
            )
            let cellHeight: CGFloat = collectionView.frame.height
            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            let width = (view.frame.width - 170)
            let cellHeight: CGFloat = collectionView.frame.height
            return CGSize(width: width, height: cellHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == bannerCollectionView {
            bannerMinimumInteritemSpacing
        } else {
            showMinimumInteritemSpacing
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == bannerCollectionView {
            bannerMinimumInteritemSpacing
        } else {
            showMinimumInteritemSpacing
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        bannerPageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
}
