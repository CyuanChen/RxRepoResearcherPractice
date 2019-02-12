//
//  LanguageViewModel.swift
//  RxRepoSearcherPractice
//
//  Created by PeterChen on 2019/2/12.
//  Copyright © 2019 PeterChen. All rights reserved.
//

import Foundation
import RxSwift
class LanguageListViewModel {
    
    // MARK: - Inputs
    let selectLanguage: AnyObserver<String>
    let cancel: AnyObserver<Void>
    
    // MARK: - Outputs
    
    let languages: Observable<[String]>
    let didSelectLanguage: Observable<String>
    let didCancel: Observable<Void>
    
    init(githubService: GithubService = GithubService()) {
        self.languages = githubService.getLanguageList()
        
        let _selectLanguage = PublishSubject<String>()
        self.selectLanguage = _selectLanguage.asObserver()
        self.didSelectLanguage = _selectLanguage.asObservable()
        
        let _cancel = PublishSubject<Void>()
        self.cancel = _cancel.asObserver()
        self.didCancel = _cancel.asObservable()
    }
    
}

