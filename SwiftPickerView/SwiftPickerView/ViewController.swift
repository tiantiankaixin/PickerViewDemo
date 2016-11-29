//
//  ViewController.swift
//  SwiftPickerView
//
//  Created by mal on 16/11/29.
//  Copyright © 2016年 mal. All rights reserved.
//

import UIKit

let rowHeight = CGFloat(30)

class ViewController: UIViewController,MPickerViewProtrol {
    
    var arr1 = [String]()
    var arr2 = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for idx in 1...24{
            self.arr1.append(String.init(format: "%.2d点", idx))
        }
        let arr = ["0分","15分","30分","45分"]
        self.arr2.append(contentsOf: arr)
        
        let mPicker = MPickerView.mPickerViewWithFrame(frame: CGRect.init(x: 100, y: 100, width: 200, height: 5 * rowHeight), m_protrol: self)
        mPicker.selectRow(row: 0, inSection: 0)
        mPicker.selectRow(row: 0, inSection: 1)
        self.view.addSubview(mPicker)
    }
    
    func m_noOfSections() -> Int {
        
        return 2
    }
    
    func m_noOfRowsInSection(section: Int) -> Int {
        
        var rows = 0
        if  section == 0{
            rows = self.arr1.count
        }
        else if section == 1{
            rows = self.arr2.count
        }
        return rows
    }
    
    func m_rowHeight() -> CGFloat {
        
        return rowHeight
    }
    
    func m_viewForRow(row: Int, inSection: Int) -> UIView {
        
        var str = ""
        if  inSection == 0{
            str = self.arr1[row]
        }
        else if inSection == 1{
            str = self.arr2[row]
        }
        let label = UILabel()
        label.text = str
        label.textAlignment = NSTextAlignment.center
        return label
    }
    
    func m_centerLineColor() -> UIColor {
        
        return UIColor.black
    }
    
    func m_selectRow(row: Int, section: Int, itemArray: [UIView]) {
        
        for (idx,itemView) in itemArray.enumerated(){
            
            if  itemView.isKind(of: UILabel.self){
                
                let label = itemView as! UILabel
                if  idx == row{
                    
                    label.textColor = UIColor.red
                }
                else{
                    
                    label.textColor = UIColor.black
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


