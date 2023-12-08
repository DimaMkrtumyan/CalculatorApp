//
//  CustomLabel.swift
//  Calculator_App
//
//  Created by Dmitriy Mkrtumyan on 14.08.23.
//

import UIKit

class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialConfig()
    }
    
    private func initialConfig() {
        font = .systemFont(ofSize: 30)
        adjustsFontSizeToFitWidth = true
        backgroundColor = #colorLiteral(red: 0.2651473284, green: 0.2651473284, blue: 0.2651473284, alpha: 1)
        textColor = .white
        highlightedTextColor = .lightGray
        textAlignment = .center
        clipsToBounds = true
    }
    
}
