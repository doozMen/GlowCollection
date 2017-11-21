//
//  GlowCollectionViewController.swift
//  GlowCollection
//
//  Created by Stijn Willems on 21/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

import UIKit

private let reuseIdentifier = "glowCell"

class GlowCollectionViewController: UICollectionViewController {

    private var colors: [UIColor] = Array(repeatElement(UIColor.red, count: 2000))

    @IBOutlet weak var glowLayout: GlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.allowsMultipleSelection = false
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GlowCollectionViewCell

        cell.color =  colors[indexPath.row]
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let previousSelectedIndexPath = collectionView.indexPathsForSelectedItems?.first else {
            return true
        }

        let cell = collectionView.cellForItem(at: previousSelectedIndexPath) as! GlowCollectionViewCell
        cell.removeGlow()
        glowLayout.indexpathForGlow = nil
        let invalidContext = UICollectionViewFlowLayoutInvalidationContext()
        invalidContext.invalidateItems(at: [previousSelectedIndexPath])
        glowLayout.invalidateLayout(with: invalidContext)
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GlowCollectionViewCell
        cell.glow()
        glowLayout.indexpathForGlow = indexPath
        let invalidContext = UICollectionViewFlowLayoutInvalidationContext()
        invalidContext.invalidateItems(at: [indexPath])
        glowLayout.invalidateLayout(with: invalidContext)
    }

}
