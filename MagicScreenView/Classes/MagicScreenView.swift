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

public class MagicScreenView: UIView {

    public var imageEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            imageView.image = imageView.image?.withAlignmentRectInsets(imageEdgeInsets)
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    public var contentInset: UIEdgeInsets = .zero {
        didSet {
            scrollView.contentInset = contentInset
        }
    }
    
    public var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    public var isDebugEnabled = false
    
    private(set) var image: UIImage?
    
    private var contentActions: [MagicAction] = []
    
    private var contentView = UIView()
    
    private lazy var imageView: DynamicImageView = {
        let imageView = DynamicImageView()
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // MARK: - Init
    
    public init(image: UIImage? = nil) {
        self.image = image
        super.init(frame: .zero)
        
        setupLayout()
        addImageViewObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeImageViewObserver()
    }
    
    // MARK: - Public
    
    public func configure(withImage image: UIImage?) {
        self.imageView.image = image
        self.imageEdgeInsets = { self.imageEdgeInsets }()
        self.contentInset = { self.contentInset }()
        addActionButtons()
    }
    
    public func addActions(_ actions: [MagicAction]) {
        actions.forEach { addAction($0) }
    }
    
    public func addAction(_ action: MagicAction) {
        guard action.frame != .zero else { return }
        contentActions.append(action)
    }
    
    // MARK: - Observers
    
    private var imageViewObserver: NSKeyValueObservation?

    private func addImageViewObserver() {
        imageViewObserver = imageView.observe(\.bounds) { [weak self] _, _ in
            guard let `self` = self else { return }
            self.didLayoutImageView()
        }
    }
    
    private func removeImageViewObserver() {
        imageViewObserver?.invalidate()
    }
    
    private func didLayoutImageView() {
        addActionButtons()
    }
    
    // MARK: - Private
    
    private func setupLayout() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: heightAnchor)
        heightConstraint.priority = UILayoutPriority(rawValue: 250)
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            heightConstraint
        ])
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc private func contentAction(_ sender: MagicButton) {
        sender.action?.actionHandler?()
    }

    private func addActionButtons() {
        guard let image = imageView.image else { return }
        imageView.subviews.forEach { $0.removeFromSuperview() }
        
        let imageViewContentSize = imageView.intrinsicContentSize
        let imageSize = image.size
        
        for action in contentActions {
            let x = CGFloat(action.frame.origin.x / imageSize.width) * imageViewContentSize.width
            let y = CGFloat(action.frame.origin.y / imageSize.height) * imageViewContentSize.height
            let width = CGFloat(action.frame.width / imageSize.width) * imageViewContentSize.width
            let height = CGFloat(action.frame.height / imageSize.height) * imageViewContentSize.height
            
            let actionButton = MagicButton(
                action: action,
                frame: CGRect(x: x, y: y, width: width, height: height),
                isDebugEnabled: isDebugEnabled
            )
            actionButton.addTarget(self, action: #selector(contentAction), for: action.controlEvent)
            imageView.addSubview(actionButton)
        }
    }
}
