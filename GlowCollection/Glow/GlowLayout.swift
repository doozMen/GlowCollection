//
//  GlowLayout.swift
//  GlowCollection
//
//  Created by Stijn Willems on 21/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

import UIKit

class GlowLayout: UICollectionViewFlowLayout {

    var indexpathForGlow: IndexPath?

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // We map this because standard UICollectionFlowLayout does not distinguish between layouts at a specific indexPath
        let arr = super.layoutAttributesForElements(in: rect)!
        return arr.map {
            atts in

            var atts = atts
            if atts.representedElementCategory == .cell {
                let ip = atts.indexPath
                atts = self.layoutAttributesForItem(at:ip)!
            }
            return atts
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        print("✨ layout attributes at item \(indexPath.item)")

        let attribute = super.layoutAttributesForItem(at: indexPath)

        guard  indexpathForGlow?.row == indexPath.row, indexpathForGlow?.section == indexPath.section else {
            return attribute
        }

        // configure z index

        attribute?.zIndex = 1000
        return attribute

    }
}
