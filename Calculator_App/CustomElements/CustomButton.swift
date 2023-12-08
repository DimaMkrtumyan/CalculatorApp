//
//  CustomButton.swift
//  Calculator_App
//
//  Created by Dmitriy Mkrtumyan on 10.08.23.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialConfig()
    }
    
    private func initialConfig() {
        titleLabel?.font = .systemFont(ofSize: 30)
        titleLabel?.adjustsFontSizeToFitWidth = true
        backgroundColor = #colorLiteral(red: 0.2651473284, green: 0.2651473284, blue: 0.2651473284, alpha: 1)
        setTitleColor(.white, for: .normal)
        setTitleColor(.lightGray, for: .highlighted)
    }
}
