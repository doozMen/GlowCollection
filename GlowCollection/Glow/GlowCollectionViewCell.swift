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
        animateGlowIn { _ in

        }
    }

    func removeGlow() {
        removeGlowIN(animated: true) {[weak self] (_) in
            self?.clipsToBounds = true
            self?.glowView?.removeFromSuperview()
        }
    }

    private func animateGlowIn(completion: @escaping (Bool) -> Void) {
        guard let view = glowView else {
            completion(false)
            return
        }

        glowView?.transform = view.transform.scaledBy(x: 0.01, y: 0.01)

        UIView.animate(withDuration: 0.7, delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.7,
                       options: .allowUserInteraction, animations: {
            view.transform = CGAffineTransform.identity
        }, completion: completion)
    }

    private func removeGlowIN (animated: Bool, completion: @escaping (Bool) -> Void) {
        guard let view = glowView, animated else {
            completion(false)
            return
        }

        glowView?.transform = view.transform.scaledBy(x: 1.0, y: 1.0)

        UIView.animate(withDuration: 0.7, delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.7,
                       options: .allowUserInteraction, animations: {
                        view.transform = view.transform.scaledBy(x: 0.0, y: 0.0)
        }, completion: completion)

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        clipsToBounds = true
        glowView?.removeFromSuperview()
    }

}
