//
//  PageViewOption.swift
//  PageView
//
//  Created by QUỐC on 4/4/19.
//  Copyright © 2019 QUỐC. All rights reserved.
//

import Foundation
import UIKit

open class TabPageView {
    
    open var title:String!
    open var nameImage:String!
    
    public init(title:String, image:String) {
        self.title = title
        self.nameImage = image
    }
}

open class PageViewOption {
    
    // Tabs Customization
    public var backgroundDefaultColor:UIColor = UIColor.white
    public var backgroundColorViewLineBottom:UIColor = UIColor.lightGray
    
    // Tab Properties
    public var tabViewHeight:CGFloat = 50.0
    public var imageHeight:CGFloat = 25.0
    public var tabViewTextFont:UIFont = UIFont.boldSystemFont(ofSize: 16)
    public var tabViewTextColorHighlight:UIColor = UIColor.black
    public var tabViewTextColorUnHighlight:UIColor = UIColor.lightGray
    
    
    // Tab Indicator
    public var indicatorViewHeight:CGFloat = 3
    public var indicatorBackgroundColor:UIColor = UIColor.red
    
    // Tab Style
    public var tabStyle:TabViewType = TabViewType.text
    
    public init() {}
}

public enum TabViewType {
    case text
    case image
    case imageWithText
}

struct Margin {
    static let SCREEN_SIZE: CGRect = UIScreen.main.bounds
    static let SCREEN_WIDTH = SCREEN_SIZE.width
    static let SCREEN_HEIGHT = SCREEN_SIZE.height
    static let SAFE_TOP: CGFloat = SCREEN_HEIGHT >= 792 ? 44.0 : 20
    static let SAFE_BOTTOM: CGFloat = SCREEN_HEIGHT >= 792 ? 34.0 : 0
    static let NAVI_HEIGHT: CGFloat = 44
}

