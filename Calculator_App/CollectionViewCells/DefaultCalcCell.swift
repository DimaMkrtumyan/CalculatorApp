//
//  DefaultCalcCell.swift
//  Calculator_App
//
//  Created by Dmitriy Mkrtumyan on 10.08.23.
//

import UIKit

final class DefaultCalcCell: UICollectionViewCell {
    
    lazy var digitButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        uiConfig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        uiConfig()
    }
    
    func setupCell(titleColor: UIColor? = nil, backgroundColor: UIColor? = nil) {
        if let backgroundColor, let titleColor {
            digitButton.backgroundColor = backgroundColor
            digitButton.setTitleColor(titleColor, for: .normal)
        }
    }
    
    func setupTitle(label: String) {
        digitButton.setTitle(label, for: .normal)
        digitButton.setTitle(label, for: .highlighted)
    }
    
    private func uiConfig() {
        addSubview(digitButton)
        NSLayoutConstraint.activate([
            digitButton.topAnchor.constraint(equalTo: topAnchor),
            digitButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            digitButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            digitButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            digitButton.widthAnchor.constraint(equalToConstant: bounds.size.width),
            digitButton.heightAnchor.constraint(equalToConstant: bounds.size.height)
        ])
    }
    
}
