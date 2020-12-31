//
//  RoundedButton.swift
//  Room-Painter
//
//  Created by verebes on 30/12/2020.
//

import UIKit

final class RoundedButton: UIButton {

    init(title: String = "No title", fontSize: CGFloat = 25) {
        super.init(frame: .zero)
        setupButton(title: title, fontSize: fontSize)
   }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = .white
                setTitleColor(ThemeColors.buttonColor, for: .highlighted)
                layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
                layer.borderColor = ThemeColors.buttonColor.cgColor

            } else {
                backgroundColor = ThemeColors.buttonColor
                titleLabel?.textColor = .white
                layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
                layer.borderColor = UIColor.white.cgColor
            }
        }
    }
    
    private func setupButton(title: String, fontSize: CGFloat = 25) {
        setTitle(title, for: .normal)
        titleLabel?.textColor = .white
        titleLabel?.font = UIFontMetrics(forTextStyle: UIFont.TextStyle.body).scaledFont(for: UIFont(name: "Helvetica-Bold", size: fontSize)!)
        backgroundColor = ThemeColors.buttonColor.withAlphaComponent(0.5)
        layer.masksToBounds = true
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 20
        isOpaque = false
        translatesAutoresizingMaskIntoConstraints = false
        
        setShadow()
    }
    
    
    private func setShadow() {
        layer.shadowColor = ThemeColors.shadowColor
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
        clipsToBounds = true
        layer.masksToBounds = false
    }

}

