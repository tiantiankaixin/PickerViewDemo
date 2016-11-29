//
//  MPickerView.swift
//  SwiftStudy3.0
//
//  Created by mal on 16/11/24.
//  Copyright © 2016年 maliang. All rights reserved.
//

import UIKit

protocol MPickerViewProtrol {
    
    /// 返回pickerview的列数
    ///
    /// - Returns: 列数
    func m_noOfSections() -> Int
    
    /// 每一列的行数
    ///
    /// - Parameter section: 列
    /// - Returns: 行数
    func m_noOfRowsInSection(section:Int) -> Int
    
    /// 行高
    ///
    /// - Returns: 行高
    func m_rowHeight() -> CGFloat
    
    /// 类似于tableView的cellForRow,返回每一行显示的view
    ///
    /// - Parameters:
    ///   - row: view所在行
    ///   - inSection: view所在列
    /// - Returns: UIView
    func m_viewForRow(row:Int, inSection:Int) -> UIView
    
    /// 中间分割线颜色
    ///
    /// - Returns: UIColor
    func m_centerLineColor() -> UIColor
    
    /// 选中行回调
    ///
    /// - Parameters:
    ///   - row: 被选中的行
    ///   - section: 被选中的列
    ///   - itemArray: 被选中的[view]
    func m_selectRow(row:Int, section:Int, itemArray:[UIView])
}

class MPickerView: UIView,UIScrollViewDelegate {
    
    var mProtrol : MPickerViewProtrol?
    var rowHeight:CGFloat = 0.0
    lazy var scrollViewArray = [UIScrollView]()
    lazy var itemViewsArray  = [[UIView]]()
    
    //MARK: get方法
    var lineView:UIView{
        
        let lineView = UIView.init(frame: self.bounds)
        lineView.height = self.rowHeight
        lineView.centerY = self.height / 2
        let topline = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: 0.5))
        topline.isUserInteractionEnabled = false
        topline.backgroundColor = UIColor.black
        let bottomline = UIView.init(frame: CGRect.init(x: 0, y: lineView.height, width: self.width, height: 0.5))
        bottomline.isUserInteractionEnabled = false
        bottomline.backgroundColor = UIColor.black
        lineView.addSubview(topline)
        lineView.addSubview(bottomline)
        lineView.isUserInteractionEnabled = false
        return lineView
    }
    
    var scrollView:UIScrollView{
        
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.height = self.height
        let sectionNo = self.mProtrol!.m_noOfSections()
        scrollView.width = self.width / CGFloat(sectionNo)
        scrollView.delegate = self
        let tapGes = UITapGestureRecognizer.init(target: self, action:#selector(tapScrollView(ges:)))
        scrollView.addGestureRecognizer(tapGes)
        return scrollView
    }
    
    func tapScrollView(ges:UITapGestureRecognizer) {
        
        let scrollView = ges.view as! UIScrollView
        let section = self.scrollViewArray.index(of: scrollView)
        let tapPoint = ges.location(in: scrollView)

        let itemsArray = self.itemViewsArray[section!]
        for (idx,item) in itemsArray.enumerated(){
        
            if item.frame.contains(tapPoint){
                self.selectRow(row: idx, inSection: section!)
                break
            }
        }
    }
    
    //MARK: 初始化方法
    /// 初始化pickerview
    ///
    /// - Parameters:
    ///   - frame: height = 奇数行 * 行高
    ///   - m_protrol: 代理
    /// - Returns: MPickerView*
    class func mPickerViewWithFrame(frame:CGRect, m_protrol:MPickerViewProtrol) -> MPickerView{
    
        let mPicker = MPickerView.init(frame: frame)
        mPicker.mProtrol = m_protrol
        mPicker.setUpView()
        return mPicker
    }
    
    func setUpView() {
        
        self.rowHeight = self.mProtrol!.m_rowHeight()
        let sectionNo = self.mProtrol!.m_noOfSections()
        let sectionWidth = self.width / CGFloat(sectionNo)
        let addRows =  Int(self.height / self.rowHeight) - 1
        for section in 0...sectionNo - 1{
            
            let scrollView = self.scrollView
            scrollView.left = CGFloat(section) * sectionWidth
            let rows = self.mProtrol!.m_noOfRowsInSection(section: section)
            let contentH =  self.rowHeight * CGFloat(rows + addRows)
            scrollView.contentSize = CGSize.init(width: 0, height: contentH)
            var itemArray = [UIView]()
            for row in 0...rows - 1{
            
                let itemView = self.mProtrol!.m_viewForRow(row: row, inSection: section)
                itemView.width = sectionWidth
                itemView.height = self.rowHeight
                itemView.top = CGFloat(row + addRows / 2) * self.rowHeight
                scrollView.addSubview(itemView)
                itemArray.append(itemView)
            }
            self.itemViewsArray.append(itemArray)
            self.scrollViewArray.append(scrollView)
            self.addSubview(scrollView)
        }
        self.addSubview(self.lineView)
    }
    
    //MARK: scrollview代理
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.fitContentOffSet(scrollView: scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if decelerate == false {
            
            self.fitContentOffSet(scrollView: scrollView)
        }
    }
    
    //MARK: function
    func fitContentOffSet(scrollView:UIScrollView){
        
        let contentOffSetY = scrollView.contentOffset.y
        var scrollToRow = Int(contentOffSetY) / Int(self.rowHeight)
        let moreMove = Int(contentOffSetY) % Int(self.rowHeight)
        if moreMove > Int(self.rowHeight / 2){
            
            scrollToRow += 1
        }
        if let section = self.scrollViewArray.index(of: scrollView){
        
            self.selectRow(row: scrollToRow, inSection: section)
        }
    }
    
    func selectRow(row : Int, inSection : Int) {
        
        let scrollView = self.scrollViewArray[inSection]
        scrollView.setContentOffset(CGPoint.init(x: 0, y: CGFloat(row) * self.rowHeight), animated: true)
        self.mProtrol!.m_selectRow(row: row, section: inSection, itemArray: self.itemViewsArray[inSection])
    }
}
