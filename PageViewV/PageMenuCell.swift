//
//  MenuCell.swift
//  SlideMenu
//
//  Created by QUỐC on 4/4/19.
//  Copyright © 2019 QUỐC. All rights reserved.
//

import Foundation
import UIKit

class PageMenuCell: UICollectionViewCell {
    
    private var colorHighLight: UIColor! = UIColor.black
    private var colorUnHighLight: UIColor! = UIColor.lightGray
    
    var option:PageViewOption!{
        didSet{
            setUpView()
            label.font = option.tabViewTextFont
            colorHighLight = option.tabViewTextColorHighlight
            colorUnHighLight = option.tabViewTextColorUnHighlight
            label.textColor = isSelected ? colorHighLight : colorUnHighLight
        }
    }
    
    var tabView:TabPageView!{
        didSet{
            label.text = tabView.title
            image.image = UIImage(named: tabView.nameImage)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            label.textColor = isSelected ? colorHighLight : colorUnHighLight
        }
    }
    
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.lightGray
        return lbl
    }()
    
    private lazy var image: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setUpView(){
        switch option.tabStyle {
        case .text:
            setUpLabel()
        case .image:
            setUpImage()
        default:
            setUpImageAndText()
        }
    }
    
    private func setUpLabel(){
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setUpImage(){
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: option.imageHeight).isActive = true
        image.heightAnchor.constraint(equalToConstant: option.imageHeight).isActive = true
    }
    
    private func setUpImageAndText(){
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor,constant: 3).isActive = true
        image.widthAnchor.constraint(equalToConstant: option.imageHeight).isActive = true
        image.heightAnchor.constraint(equalToConstant: option.imageHeight).isActive = true
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 3).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
