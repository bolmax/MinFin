//
//  ApplicationStoryboard.swift
//  MB
//
//  Created by Max Bolotov on 05.08.2020.
//  Copyright © 2020 Max Bolotov. All rights reserved.
//

import UIKit

enum ApplicationStoryboard: String {
    
    // MARK: Storyboards names
    
    case main
    
    var storyboardInstance : UIStoryboard {
        return UIStoryboard(name: self.rawValue.capitalized, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T? {
        let storyboardId = (viewControllerClass as UIViewController.Type).storyboardId
        return storyboardInstance.instantiateViewController(withIdentifier: storyboardId) as? T
    }
    
    func initialViewController() -> UIViewController? {
        return storyboardInstance.instantiateInitialViewController()
    }
}

extension UIViewController {
    
    class var storyboardId: String {
        return "\(self)"
    }
    
    static func instantiate(from storyboard: ApplicationStoryboard) -> Self? {
        return storyboard.viewController(viewControllerClass: self)
    }
}
