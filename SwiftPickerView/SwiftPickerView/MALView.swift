//
//  MALView.swift
//  SwiftStudy3.0
//
//  Created by maliang on 2016/11/23.
//  Copyright © 2016年 maliang. All rights reserved.
//

import UIKit

let MNotSet = CGFloat.greatestFiniteMagnitude
let MScreenSize = UIScreen.main.bounds.size
let MScreenWidth = MScreenSize.width
let MScreenHeight = MScreenSize.height

extension UIView{

    //MARK: frame相关
    /**
     设置frame
     
     :param: X      横坐标  不设置传入MNotSet
     :param: Y      纵坐标  不设置传入MNotSet
     :param: Width  宽度    不设置传入MNotSet
     :param: Height 高度    不设置传入MNotSet
     */
    func setViewFrameWithX(_ X:CGFloat, Y:CGFloat, Width:CGFloat, Height:CGFloat) -> Void{
        
        var viewFrame = self.frame
        
        if X != MNotSet
        {
            viewFrame.origin.x = X
        }
        
        if Y != MNotSet
        {
            viewFrame.origin.y = Y
        }
        
        if Width != MNotSet
        {
            viewFrame.size.width = Width
        }
        
        if Height != MNotSet
        {
            viewFrame.size.height = Height
        }
        
        self.frame = viewFrame
    }

    
    var left:CGFloat{
       
        get{
            
            return self.frame.origin.x
        }
        set(newValue){
        
            setViewFrameWithX(newValue, Y: MNotSet, Width: MNotSet, Height: MNotSet)
        }
    }
    
    var right:CGFloat{
    
        get{
        
            return self.left + self.width
        }
        set(newValue){
        
            self.left = newValue - self.width
        }
    }
    
    var top:CGFloat{
    
        get{
        
            return self.frame.origin.y
        }
        set(newValue){
        
            setViewFrameWithX(MNotSet, Y: newValue, Width: MNotSet, Height: MNotSet)
        }
    }
    
    var bottom:CGFloat{
    
        get{
        
            return self.top + self.height
        }
        set(newValue){
        
            self.top = newValue - self.height
        }
    }
    
    var origin:CGPoint{
    
        get{
        
            return self.frame.origin
        }
        set(newValue){
        
            setViewFrameWithX(newValue.x, Y: newValue.y, Width: MNotSet, Height: MNotSet)
        }
    }
    
    var size:CGSize{
    
        get{
        
            return self.frame.size
        }
        set(newValue){
        
            setViewFrameWithX(MNotSet, Y: MNotSet, Width: newValue.width, Height: newValue.height)
        }
    }
    
    var width:CGFloat{
    
        get{
        
            return self.frame.size.width
        }
        set(newValue){
        
            setViewFrameWithX(MNotSet, Y: MNotSet, Width: newValue, Height: MNotSet)
        }
    }
    
    var height:CGFloat{
    
        get{
        
            return self.frame.size.height
        }
        set(newValue){
            
            setViewFrameWithX(MNotSet, Y: MNotSet, Width: MNotSet, Height: newValue)
        }
    }
    
    var centerX:CGFloat{
    
        get{
        
            return self.center.x
        }
        set(newValue){
        
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    var centerY:CGFloat{
    
        get{
        
            return self.center.y
        }
        set(newValue){
        
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    //MARK: layer相关
    func setCornerRadius(radius:CGFloat) {
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
