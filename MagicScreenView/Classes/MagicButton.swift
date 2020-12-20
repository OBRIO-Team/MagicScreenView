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

final class MagicButton: UIButton {
    
    var action: MagicAction?
    
    init(action: MagicAction, frame: CGRect, isDebugEnabled: Bool = false) {
        super.init(frame: frame)
        
        self.action = action
        self.touchAreaInset = action.touchAreaInset
        
        if isDebugEnabled {
            addBorder()
            if touchAreaInset != .zero {
                addTouchAreaBorder()
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func addBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0 / 255, green: 230 / 255, blue: 118 / 255, alpha: 1).cgColor
    }
    
    private func addTouchAreaBorder() {
        guard let touchAreaInset = action?.touchAreaInset else { return }
        layer.addBorder(frame: CGRect(x: -touchAreaInset,
                                      y: -touchAreaInset,
                                      width: frame.width + 2 * touchAreaInset,
                                      height: frame.height + 2 * touchAreaInset),
                        color: UIColor(red: 0 / 255, green: 176 / 255, blue: 255 / 255, alpha: 1),
                        thickness: 1
        )
    }
}
