//
//  GlowCollectionViewCell.swift
//  GlowCollection
//
//  Created by Stijn Willems on 21/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

import UIKit

class GlowCollectionViewCell: UICollectionViewCell {

    @IBOutlet var colorView: UIView!

    private var glowView: UIView?

    func glow() {
        clipsToBounds = false

        glowView = UIView(frame: self.frame)
        glowView?.backgroundColor = UIColor.yellow
        
        glowView?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(glowView!)

        glowView?.topAnchor.constraint(equalTo: self.topAnchor, constant: -10).isActive = true
        glowView?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true

        glowView?.leftAnchor.constraint(equalTo: leftAnchor, constant: -10).isActive = true
        glowView?.rightAnchor.constraint(equalTo: rightAnchor, constant: 10).isActive = true

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clipsToBounds = true
        glowView?.removeFromSuperview()
    }

}
