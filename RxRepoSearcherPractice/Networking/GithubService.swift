//
//  GithubService.swift
//  RxRepoSearcherPractice
//
//  Created by PeterChen on 2019/2/12.
//  Copyright © 2019 PeterChen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum ServiceError: Error {
    case cannotParse
}

class GithubService {
    private let session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getLanguageList() -> Observable<[String]> {
        return Observable.just([
            "Swift",
            "Objective-C",
            "Java",
            "C",
            "C++",
            "JavaScript",
            "Python",
            "R",
            "Ruby"
            ])
    }
    
    func getMostPopularRepositories(byLanguage language: String) -> Observable<[Repository]> {
        let encodedLanguage = language.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "https://api.github.com/search/repositories?q=language:\(encodedLanguage)&sort=stars")!
        return session.rx
            .json(url: url)
            .flatMap { json throws -> Observable<[Repository]> in
                guard
                    let json = json as? [String: Any],
                    let itemsJSON = json["items"] as? [[String: Any]]
                else { return
                    Observable.error(ServiceError.cannotParse)
                }
                
                let repositories = itemsJSON.compactMap(Repository.init)
                return Observable.just(repositories)
                
                }
    }
}


class ViewModel {
    var buttonTap: Observable<Void>!
    var usernameText: Observable<String>!
    
    func setInputs(tap: Observable<Void>, username: Observable<String>) {
        buttonTap = tap
        usernameText = username
    }
    
    func buttonEnabled() -> Observable<Bool> {
        return usernameText?.map { $0 != nil } ?? Observable.empty()
    }
}


