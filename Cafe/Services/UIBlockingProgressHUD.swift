//
//  UIBlockingProgressHUD.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 26.12.2023.
//

import UIKit
import ProgressHUD

final class UIBlockingProgressHUD {
    private static var window: UIWindow? {
        SceneDelegate.getCurrentWindow()
    }
    
    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.animate()
    }
    
    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}
