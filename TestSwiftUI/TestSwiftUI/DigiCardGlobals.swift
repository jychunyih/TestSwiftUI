//
//  DigiCardGlobals.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/12.
//  Copyright © 2016年 chunyih. All rights reserved.
//

import Foundation
import UIKit

public class ResourceIdentifer{
    // MARK: View Controller Storyboard id
    public static let MAIN_CARD_LIST = "maincardlist"
    public static let TAKE_PHOTO = "takephoto"
    public static let MAIN_NAV = "mainnav"
    
    // MARK: Segue id
    public static let MAIN_CARD_LIST_TO_CAMERA = "maincardlisttocamera"
}


public class DigiCardGlobals{
    
    static let stringsTable = "Localizable"
    
    // MARK: Config for PhotoGallery
    
    static func getPhotoLibraryThumbnailSize() -> CGSize {
        let thumbnailDimension = (UIScreen.mainScreen().bounds.width - ((columns * itemSpacing) - itemSpacing))/columns
        return CGSizeMake(thumbnailDimension, thumbnailDimension)
    }
    
    static func getCameraBundle() -> NSBundle{
        return NSBundle(forClass: CameraView.self)
    }
    
    static let itemSpacing: CGFloat = 1
    static let columns: CGFloat = 4
    static let scale = UIScreen.mainScreen().scale
    
}
