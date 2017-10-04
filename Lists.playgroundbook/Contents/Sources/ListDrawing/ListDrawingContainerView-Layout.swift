import Foundation
import UIKit

extension ListDrawingContainerView {
    
    internal func addListView(marginToTop: CGFloat, i: Int) {
        let listDrawingView: ListDrawingView<T> = ListDrawingView(list: lists[i], frame: CGRect(x: 0, y: 0, width: CGFloat(lists[i].size + 2) * 144, height: mainViewHeight), listNodeDelegate: nil, canEdit: false)
        
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: listDrawingView.totalWidth, height: mainViewHeight)
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        scrollView.addSubview(listDrawingView)
        
        var tempView: UIView = scrollView
        addConstraints(toView: &tempView, leading: 0, top: marginToTop, trailing: 0, height: mainViewHeight)
    }
    
    internal func addLabel(text: String, marginToTop: CGFloat) {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.blue
        addSubview(label)
        var tempView: UIView = label
        addConstraints(toView: &tempView, leading: 0, top: marginToTop, trailing: 20, height: labelHeight)
    }
    
    internal func addTextView(text: String, marginToTop: CGFloat) {
        let textView = UITextView()
        textView.text = text
        textView.backgroundColor = UIColor.white
        textView.textAlignment = .natural
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        textView.isEditable = false
        textView.isSelectable = false
        textView.showsVerticalScrollIndicator = false
        addSubview(textView)
        var tempView: UIView = textView
        addConstraints(toView: &tempView, leading: 100, top: marginToTop, trailing: 0, height: operationsInfoHeight - 40)
    }
    
    private func addConstraints(toView view: inout UIView, leading: CGFloat, top: CGFloat, trailing: CGFloat, height: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: leading))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: trailing))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: top))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height))
    }
    
}
