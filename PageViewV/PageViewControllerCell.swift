//
//  PageViewCell.swift
//  SlideMenu
//
//  Created by QUỐC on 4/4/19.
//  Copyright © 2019 QUỐC. All rights reserved.
//

import Foundation
import UIKit

class PageViewControllerCell: UICollectionViewCell {
    
    var viewController:UIViewController!{
        didSet{
            self.addSubview(viewController.view)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            viewController.view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            viewController.view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            viewController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
