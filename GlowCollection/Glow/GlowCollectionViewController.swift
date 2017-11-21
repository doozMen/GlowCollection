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

        if collectionView.indexPathsForSelectedItems?.contains(where: { (selectedIndexPath) -> Bool in
            return indexPath.row == selectedIndexPath.row  && indexPath.section == selectedIndexPath.section
        }) ?? false {
            cell.glow()
        } else {
            cell.removeGlow()
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let previousSelectedIndexPath = collectionView.indexPathsForSelectedItems?.first,
            let cell = collectionView.cellForItem(at: previousSelectedIndexPath) as? GlowCollectionViewCell else {
                // This case happens when there is no previous selection or the cell is scrolled out of view
            return true
        }


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
