//  github: https://github.com/MakeZL/MLSwiftBasic
//  author: @email <120886865@qq.com>
//
//  MBNavigationBarView.swift
//  MakeBolo
//
//  Created by 张磊 on 15/6/22.
//  Copyright (c) 2015年 MakeZL. All rights reserved.
//

import UIKit

protocol MBNavigationBarViewDelegate:NSObjectProtocol{
   func goBack()
}

class MBNavigationBarView: UIView {
    var titleImage,leftImage,rightImage:String!
    var rightTitleBtns:NSMutableArray = NSMutableArray()
    weak var delegate:MBNavigationBarViewDelegate!
    var rightItemWidth:CGFloat!{
        willSet{
            var count = self.rightTitleBtns.count ?? self.rightImgs.count
            if count > 0 {
                for (var i = 0; i < count; i++){
                    if var button = self.rightTitleBtns[i] as? UIButton ?? self.rightImgs[i] as? UIButton {
                        button.frame.size.width = newValue
                        var x = self.frame.size.width - newValue * CGFloat(i) - newValue
                        button.frame = CGRectMake(x, NAV_BAR_Y, newValue, NAV_BAR_HEIGHT) ;
                    }
                }
                self.titleButton.frame.size.width = self.frame.size.width - NAV_ITEM_LEFT_W - newValue * CGFloat(count)
            }else {
                self.titleButton.frame.size.width = self.frame.size.width - NAV_ITEM_LEFT_W - NAV_ITEM_RIGHT_W
                self.rightButton.frame.size.width = newValue
                self.rightButton.frame.origin.x = self.frame.size.width - newValue
            }
        }
    }
    
    var leftItemWidth:CGFloat!
    var title:String{
        set {
            self.titleButton.setTitle(newValue, forState: .Normal)
        }
        
        get {
            if (self.titleButton.currentTitle != nil) {
                return self.titleButton.currentTitle!
            }else{
                return ""
            }
        }
    }
    
    var leftStr:String{
        set {
            self.leftButton.setTitle(newValue, forState: .Normal)
        }
        
        get {
            if (self.leftButton.currentTitle != nil) {
                return self.leftButton.currentTitle!
            }else{
                return ""
            }
        }
    }
    
    var rightImgs:NSArray{
        set{
            
            var allImgs = newValue.reverseObjectEnumerator().allObjects
            
            for (var i = 0; i < allImgs.count; i++){
                var rightButton = UIButton.buttonWithType(.Custom) as! UIButton
                rightButton.tag = i
                rightButton.setTitleColor(NAV_TEXT_COLOR, forState: .Normal)
                var x = self.frame.size.width - CGFloat(NAV_ITEM_RIGHT_W) * CGFloat(i) - NAV_ITEM_LEFT_W
                rightButton.setImage(UIImage(named: allImgs[i] as! String), forState: .Normal)
                rightButton.frame = CGRectMake(x, NAV_BAR_Y, NAV_ITEM_RIGHT_W, NAV_BAR_HEIGHT) ;
                rightButton.titleLabel?.font = NAV_ITEM_FONT
                rightButton.autoresizingMask = .FlexibleRightMargin | .FlexibleLeftMargin
                self.addSubview(rightButton)
                rightTitleBtns.addObject(rightButton)
                
            }
            
            if (newValue.count > 1){
                if self.rightItemWidth > 0 {
                    self.titleButton.frame.size.width = self.frame.size.width - self.rightItemWidth * CGFloat((newValue.count)) - NAV_ITEM_LEFT_W
                }else{
                    self.titleButton.frame.size.width = self.frame.size.width - NAV_ITEM_RIGHT_W * CGFloat((newValue.count)) - NAV_ITEM_LEFT_W
                }
            }
        }
        
        get{
            return ( rightTitleBtns != false && rightTitleBtns.count > 0) ? rightTitleBtns: []
        }
    }
    
    var rightTitles:NSArray{
        set{
            for (var i = 0; i < newValue.count; i++){
                var rightButton = UIButton.buttonWithType(.Custom) as! UIButton
                rightButton.tag = i
                rightButton.setTitleColor(NAV_TEXT_COLOR, forState: .Normal)
                var x = self.frame.size.width - CGFloat(NAV_ITEM_LEFT_W) * CGFloat(i) - NAV_ITEM_RIGHT_W
                rightButton.setTitle(newValue[i] as! NSString as String, forState: .Normal)
                rightButton.frame = CGRectMake(x, NAV_BAR_Y, NAV_ITEM_RIGHT_W, NAV_BAR_HEIGHT) ;
                rightButton.titleLabel?.font = NAV_ITEM_FONT
                rightButton.autoresizingMask = .FlexibleRightMargin | .FlexibleLeftMargin
                self.addSubview(rightButton)
                self.rightTitleBtns.addObject(rightButton)
                
            }
            
            if (newValue.count > 1){
                if self.rightItemWidth > 0 {
                    self.titleButton.frame.size.width = self.frame.size.width - self.rightItemWidth * CGFloat((newValue.count)) - NAV_ITEM_LEFT_W
                }else{
                    self.titleButton.frame.size.width = self.frame.size.width - NAV_ITEM_RIGHT_W * CGFloat((newValue.count)) - NAV_ITEM_LEFT_W
                }
            }
        }
        
        get{
            return ( rightTitleBtns != false && rightTitleBtns.count > 0) ? rightTitleBtns: []
        }
    }
    
    var rightStr:String{
        set {
            self.rightButton.setTitle(newValue, forState: .Normal)
        }
        
        get {
            if (self.rightButton.currentTitle != nil) {
                return self.rightButton.currentTitle!
            }else{
                return ""
            }
        }
    }
    
    lazy var titleButton:UIButton = {
        var titleButton = UIButton.buttonWithType(.Custom) as! UIButton
        titleButton.setTitleColor(NAV_TEXT_COLOR, forState: .Normal)
        titleButton.frame = CGRectMake(NAV_ITEM_LEFT_W, NAV_BAR_Y, self.frame.size.width - NAV_ITEM_LEFT_W, NAV_BAR_HEIGHT);
        if (self.rightTitles.count > 1){
            titleButton.frame.size.width = self.frame.size.width - NAV_ITEM_RIGHT_W * CGFloat((2 + self.rightTitles.count))
            titleButton.frame.origin.x = CGFloat(self.frame.size.width - titleButton.frame.size.width) * 0.5
        }
        titleButton.autoresizingMask = .FlexibleWidth | .FlexibleLeftMargin
        titleButton.titleLabel?.font = NAV_TITLE_FONT
        self.addSubview(titleButton)
        return titleButton
    }()
    
    lazy var leftButton:UIButton = {
        var leftButton = UIButton.buttonWithType(.Custom) as! UIButton
        leftButton.setTitleColor(NAV_TEXT_COLOR, forState: .Normal)
        leftButton.frame = CGRectMake(0, NAV_BAR_Y, NAV_ITEM_LEFT_W, NAV_BAR_HEIGHT);
        leftButton.titleLabel?.font = NAV_ITEM_FONT
        self.addSubview(leftButton)
        return leftButton
    }()
    
    lazy var rightButton:UIButton = {
        var rightButton = UIButton.buttonWithType(.Custom) as! UIButton
        rightButton.setTitleColor(NAV_TEXT_COLOR, forState: .Normal)
        rightButton.frame = CGRectMake(self.frame.size.width - NAV_ITEM_RIGHT_W, NAV_BAR_Y, NAV_ITEM_RIGHT_W, NAV_BAR_HEIGHT) ;
        rightButton.titleLabel?.font = NAV_ITEM_FONT
        rightButton.autoresizingMask = .FlexibleRightMargin | .FlexibleLeftMargin
        
        self.addSubview(rightButton)
        return rightButton
    }()
    
    var back:Bool{
        set{
            if (newValue && (count(self.leftStr) <= 0 && self.leftStr.isEmpty)) {
                var backBtn = UIButton.buttonWithType(.Custom) as! UIButton
                backBtn.setTitleColor(NAV_TEXT_COLOR, forState: .Normal)
                backBtn.setImage(UIImage(named: BACK_NAME), forState: .Normal)
                backBtn.titleLabel!.textAlignment = .Left
                backBtn.frame = CGRectMake(0, NAV_BAR_Y, NAV_ITEM_LEFT_W, NAV_BAR_HEIGHT);
                backBtn.addTarget(self, action:"goBack", forControlEvents: .TouchUpInside)
                self.addSubview(backBtn)
            }
        }
        
        get{
            return self.back
        }
    }
    
    func goBack(){
        if self.delegate.respondsToSelector(Selector("goBack")) {
            self.delegate.goBack()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    
    
    func setup(){
    }
}