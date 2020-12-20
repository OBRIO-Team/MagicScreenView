//
//  MagicScreenView
//
//  Copyright (c) 2020-Present OBRIO Team - https://github.com/OBRIO-Team
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

extension UIButton {
    
    private struct AssociatedKeys {
        static var touchAreaInset = "touchAreaInset"
    }
    
    var touchAreaInset: CGFloat {
        get {
            guard let inset = objc_getAssociatedObject(self, &AssociatedKeys.touchAreaInset) as? CGFloat else { return .zero }
            return inset
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.touchAreaInset, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard touchAreaInset != .zero && isEnabled && !isHidden else {
            return super.point(inside: point, with: event)
        }
        
        let inset = UIEdgeInsets(
            top: -touchAreaInset,
            left: -touchAreaInset,
            bottom: -touchAreaInset,
            right: -touchAreaInset
        )
        let hitFrame = bounds.inset(by: inset)
        return hitFrame.contains(point)
    }
}

