//
//  ViewController.swift
//  JDR Todo 2
//
//  Created by Jayden Jang on 2023/06/10.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxRelay
import RxCocoa

/**
 *##화면 명: JDR TODO 메인화면 (TODO카드뷰, 검색, TODO추가 및 삭제)
 */
final class MainVC: BaseVC {
    
    fileprivate let searchBar = SearchBarView()
    fileprivate let todoTabelView = TodoTabelView()
    fileprivate var mainVM = mainVM()
    
    var disposeBag = DisposeBag()
    
    fileprivate lazy var titleLabel = UILabel().then {
        $0.text = "Todo List"
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 27, weight: .heavy)
    }
    
    private var addButtonConfig = UIButton.Configuration.filled()
    fileprivate lazy var addButton = UIButton().then {
        $0.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        $0.configuration = .filled()
        addButtonConfig.title = "+"
        addButtonConfig.baseBackgroundColor = .systemOrange
        addButtonConfig.cornerStyle = .capsule
        addButtonConfig.titlePadding = 10
        $0.configuration = self.addButtonConfig
    }
    
    private var filterButtonConfig = UIButton.Configuration.filled()
    fileprivate lazy var filterButton = UIButton().then {
        $0.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        $0.configuration = .filled()
        filterButtonConfig.title = "⚞"
        filterButtonConfig.baseBackgroundColor = .systemOrange
        filterButtonConfig.cornerStyle = .capsule
        filterButtonConfig.titlePadding = 10
        $0.configuration = self.filterButtonConfig
    }
    
    fileprivate lazy var topBarStackView: UIStackView = UIStackView().then {
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .horizontal
    }
    
    fileprivate lazy var btnStackView: UIStackView = UIStackView().then {
        $0.distribution = .fill
        $0.alignment = .center
        $0.axis = .horizontal
        $0.spacing = 10
    }

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - Action Method
extension MainVC {
    @objc fileprivate func addButtonPressed() {
        present(UploadVC(), animated: true, completion: nil)
    }
    
    @objc fileprivate func filterButtonPressed() {
        SearchFilterVC.shared.modalPresentationStyle = .overFullScreen
        present(SearchFilterVC.shared, animated: true, completion: nil)
    }
}
