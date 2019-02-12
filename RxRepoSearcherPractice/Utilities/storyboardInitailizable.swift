//
//  storyboardInitailizable.swift
//  RxRepoSearcherPractice
//
//  Created by PeterChen on 2019/2/12.
//  Copyright © 2019 PeterChen. All rights reserved.
//

import Foundation
import UIKit
protocol  StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardInitializable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    static func initFromStoryboard(name: String = "Main") -> Self {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
