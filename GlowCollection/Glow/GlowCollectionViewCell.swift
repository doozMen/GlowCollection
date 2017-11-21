//
//  GlowCollectionViewCell.swift
//  GlowCollection
//
//  Created by Stijn Willems on 21/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

import UIKit

class GlowCollectionViewCell: UICollectionViewCell {

    let outset:CGFloat = 50
    var color = UIColor.gray {
        didSet {
            colorView?.backgroundColor = color
        }
    }

    @IBOutlet var colorView: UIView? {
        didSet {
            colorView?.backgroundColor = color
        }
    }

    private var glowView: UIView?

    func glow() {
        print("✨ ---glow---")
        clipsToBounds = false

        glowView = UIView(frame: self.frame)
        glowView?.backgroundColor = UIColor.yellow
        glowView?.alpha = 0.5

        glowView?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(glowView!)
        sendSubview(toBack: glowView!)

        glowView?.topAnchor.constraint(equalTo: self.topAnchor, constant: -outset).isActive = true
        glowView?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: outset).isActive = true

        glowView?.leftAnchor.constraint(equalTo: leftAnchor, constant: -outset).isActive = true
        glowView?.rightAnchor.constraint(equalTo: rightAnchor, constant: outset).isActive = true
    }

    func removeGlow() {
        clipsToBounds = true
        glowView?.removeFromSuperview()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        removeGlow()
    }

}
