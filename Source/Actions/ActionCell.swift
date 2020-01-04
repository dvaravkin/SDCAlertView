import UIKit

final class ActionCell: UICollectionViewCell {

    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var rightImageView: UIImageView!
    @IBOutlet private var highlightedBackgroundView: UIView!
    @IBOutlet private var titleTrailing: NSLayoutConstraint!

    private var textColor: UIColor?
    
    var isEnabled = true {
        didSet { self.titleLabel.isEnabled = self.isEnabled }
    }

    override var isHighlighted: Bool {
        didSet { self.highlightedBackgroundView.isHidden = !self.isHighlighted }
    }

    func set(_ action: AlertAction, with visualStyle: AlertVisualStyle) {
        action.actionView = self

        self.titleLabel.font = visualStyle.font(for: action)
        
        self.textColor = visualStyle.textColor(for: action)
        self.titleLabel.textColor = self.textColor ?? self.tintColor
        
        self.titleLabel.attributedText = action.attributedTitle

        if let rightImage = action.rightImage {
            rightImageView.image = rightImage
            titleTrailing.constant = titleTrailing.constant * 2 + rightImageView.frame.size.width
            titleLabel.textAlignment = .left
        }
        
        self.highlightedBackgroundView.backgroundColor = visualStyle.actionHighlightColor

        self.setupAccessibility(using: action)
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()
        self.titleLabel.textColor = self.textColor ?? self.tintColor
    }
}

final class ActionSeparatorView: UICollectionReusableView {

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

        if let attributes = layoutAttributes as? ActionsCollectionViewLayoutAttributes {
            self.backgroundColor = attributes.backgroundColor
        }
    }
}
