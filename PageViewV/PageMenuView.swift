//
//  PageMenuView.swift
//  SlideMenu
//
//  Created by QUỐC on 4/3/19.
//  Copyright © 2019 QUỐC. All rights reserved.
//

import UIKit

protocol PageMenuViewDelegate:class {
    func scrollToViewController(_ index:Int)
}

class PageMenuView: UIView {
    
    weak var delegate: PageMenuViewDelegate!
    private let cellId = "Cell"
    private var tabViews: [TabPageView]!
    private var option:PageViewOption!
    
    private lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = option.indicatorBackgroundColor
        return view
    }()
    
    private lazy var lineBottom: UIView = {
        let view = UIView()
        view.backgroundColor = option.backgroundColorViewLineBottom
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collec = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collec.backgroundColor = .white
        if let layout = collec.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        collec.backgroundColor = option.backgroundDefaultColor
        collec.showsHorizontalScrollIndicator = false
        collec.isPagingEnabled = true
        collec.register(PageMenuCell.self, forCellWithReuseIdentifier: cellId)
        collec.dataSource = self
        collec.delegate = self
        collec.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: UICollectionView.ScrollPosition.right) //Choose Page First
        return collec
    }()
    
    var leadingAnchorIndicatorView:NSLayoutConstraint!

    init(tabViews:[TabPageView], option:PageViewOption, frame: CGRect) {
        super.init(frame: frame)
        self.option = option
        self.tabViews = tabViews
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -option.indicatorViewHeight).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        addSubview(lineBottom)
        lineBottom.translatesAutoresizingMaskIntoConstraints = false
        lineBottom.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineBottom.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineBottom.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineBottom.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        indicatorView.widthAnchor.constraint(equalToConstant: Margin.SCREEN_WIDTH/CGFloat(tabViews.count)).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: option.indicatorViewHeight).isActive = true
        leadingAnchorIndicatorView = indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 0)
        leadingAnchorIndicatorView.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didScrollToIndexPath(_ indexP:IndexPath){
        collectionView.selectItem(at: indexP, animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
    }
}

extension PageMenuView: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageMenuCell
        cell.tabView = self.tabViews[indexPath.row]
        cell.option = self.option
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/CGFloat(tabViews.count), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.scrollToViewController(indexPath.row)
    }
}
