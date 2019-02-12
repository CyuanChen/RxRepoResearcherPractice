//
//  RepositoryViewModel.swift
//  RxRepoSearcherPractice
//
//  Created by PeterChen on 2019/2/12.
//  Copyright © 2019 PeterChen. All rights reserved.
//

import Foundation
import RxSwift

class RepositoryViewModel {
    let name: String
    let description: String
    let starsCountText: String
    let url: URL
    
    init(repository: Repository) {
        self.name = repository.fullName
        self.description = repository.description
        self.starsCountText = "⭐️ \(repository.starsCount)"
        self.url = URL(string: repository.url)!
    }
}
