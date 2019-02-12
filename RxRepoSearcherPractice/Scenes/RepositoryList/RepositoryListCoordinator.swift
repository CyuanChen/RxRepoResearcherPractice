//
//  RepositoryListCoordinator.swift
//  RxRepoSearcherPractice
//
//  Created by PeterChen on 2019/2/12.
//  Copyright © 2019 PeterChen. All rights reserved.
//

import Foundation
import RxSwift
import SafariServices

class RepositoryListCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = RepositoryListViewModel(initailLanguage: "Swift")
        let viewController = RepositoryListViewController.initFromStoryboard(name: "Main")
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.viewModel = viewModel
        
        viewModel.showRepository
            .subscribe(onNext: { [weak self] in self?.showrepository(by: $0, in: navigationController)})
            .disposed(by: disposeBag)
        viewModel.showLanguageList
            .flatMap { [weak self] _ -> Observable<String?> in
                guard let `self` = self else { return .empty()} // 跟guard let repo = repo是一樣的意思
                return self.showLanguageList(on: viewController)
            }
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: viewModel.setCurrentLanguage)
            .disposed(by: disposeBag)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return Observable.never() // 因為此VC會一直顯示，因此回傳never()
    }
    
    private func showrepository(by url: URL, in navigationController: UINavigationController) {
        let safariViewController = SFSafariViewController(url: url)
        navigationController.pushViewController(safariViewController, animated: true)
    }
    
    private func showLanguageList(on rootViewController: UIViewController) -> Observable<String?> {
        let languageListCoordinator = LanguageListCoordinator(rootViewController: rootViewController)
        return coordinate(to: languageListCoordinator)
            .map { result in
                switch result {
                case .language(let language): return language
                case .cancel: return nil
                }
        }
    }
    
}
