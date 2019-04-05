//
//  PageViewController.swift
//  PageView
//
//  Created by QUỐC on 4/4/19.
//  Copyright © 2019 QUỐC. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol PageViewControllerDelegate {
    
    @objc optional func didSelectControllerAtIndex(index:Int)
    @objc optional func didMoveToControllerAtIndex(index:Int)
}

open class PageViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    private let cellId = "Cell"
    weak var delegate:PageViewControllerDelegate?
    
    private var pageMenu: PageMenuView!
    private var option: PageViewOption!
    private var viewControllers: [UIViewController]!
    private var tabViews: [TabPageView]!
    
    private lazy var collectionView: UICollectionView = {
        let collec = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collec.backgroundColor = option.backgroundDefaultColor
        if let layout = collec.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        collec.showsHorizontalScrollIndicator = false
        collec.isPagingEnabled = true
        collec.register(PageViewControllerCell.self, forCellWithReuseIdentifier: cellId)
        collec.dataSource = self
        collec.delegate = self
        return collec
    }()
    
    public init(viewControllers:[UIViewController],tabViews:[TabPageView]?,option:PageViewOption?) {
        self.viewControllers = viewControllers
        self.option = option == nil ? PageViewOption() : option
        if tabViews == nil {
            self.tabViews = [TabPageView]()
            for _ in 0..<viewControllers.count {
                self.tabViews.append(TabPageView(title: "", image: ""))
            }
        } else {
            self.tabViews = tabViews
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setUpPageMenuView()
        setUpCollectionView()
    }
    
    private func setUpPageMenuView(){
        pageMenu = PageMenuView(tabViews: tabViews, option: option, frame: .zero)
        pageMenu.delegate = self
        self.view.addSubview(pageMenu)
        pageMenu.translatesAutoresizingMaskIntoConstraints = false
        if self.navigationController != nil {
            pageMenu.topAnchor.constraint(equalTo: self.view.topAnchor,constant: Margin.SAFE_TOP + Margin.NAVI_HEIGHT).isActive = true
        } else {
            pageMenu.topAnchor.constraint(equalTo: self.view.topAnchor,constant: Margin.SAFE_TOP).isActive = true
        }
        pageMenu.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        pageMenu.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        pageMenu.heightAnchor.constraint(equalToConstant: option.tabViewHeight).isActive = true
    }
    
    private func setUpCollectionView(){
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.pageMenu.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageViewControllerCell
        cell.viewController = viewControllers[indexPath.row]
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectControllerAtIndex?(index: indexPath.row)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/collectionView.frame.width
        if floor(page) == page {
            pageMenu.didScrollToIndexPath(IndexPath(item: Int(page), section: 0))
            delegate?.didMoveToControllerAtIndex?(index: Int(page))
        }
        pageMenu.leadingAnchorIndicatorView.constant = scrollView.contentOffset.x/CGFloat(viewControllers.count)
        pageMenu.layoutIfNeeded()
    }
}

extension PageViewController:PageMenuViewDelegate
{
    func scrollToViewController(_ index: Int) {
        delegate?.didMoveToControllerAtIndex?(index: index)
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
}
