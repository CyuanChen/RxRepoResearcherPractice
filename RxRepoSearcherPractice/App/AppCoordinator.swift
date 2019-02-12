//
//  AppCoordinator.swift
//  RxRepoSearcherPractice
//
//  Created by PeterChen on 2019/2/11.
//  Copyright © 2019 PeterChen. All rights reserved.
//

import Foundation
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let repositoryListCoordinator = RepositoryListCoordinator(window: window)
        return coordinate(to: repositoryListCoordinator)
    }
}
