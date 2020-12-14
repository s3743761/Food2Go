//
//  YTButtons.swift
//  Food2Go
//
//  Created by Prabhav Mehra on 06/09/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class YTRoundedButton: UIButton {
    
    required init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
