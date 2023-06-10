//
//  TodoTableViewCell.swift
//  JDR Todo 2
//
//  Created by Jayden Jang on 2023/06/11.
//

import UIKit
import Then
import RxSwift
import RxRelay
import RxCocoa


extension Reactive where Base: TodoTableViewCell {
    var cellData: Binder<TodoCardModel> {
        return Binder(base,
                      binding: { cell, todoCard in
            cell.createdDate.text = todoCard.createdDate
            cell.lastModifiedDate.text = todoCard.lastModifiedDate
            cell.statusLabel.text = todoCard.statusInfo
            cell.statusLabel.textColor = todoCard.status ? .systemGreen : .systemBrown
            cell.titleLabel.text = todoCard.title
            cell.idLabel.text = todoCard.index
        })
    }
}

final class TodoTableViewCell: BaseTableViewCell {
    var disposeBag = DisposeBag()
    
    fileprivate lazy var verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .equalCentering
    }
    
    lazy var titleLabel = UILabel().then {
        $0.textColor = .darkText
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.textAlignment = .left
    }
    
    fileprivate lazy var dateStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fill
        $0.spacing = 5
    }
    
    lazy var createdDate = UILabel().then {
        $0.textColor = .systemGray2
        $0.font = .systemFont(ofSize: 10.5, weight: .medium)
        $0.textAlignment = .left
    }
    
    lazy var lastModifiedDate = UILabel().then {
        $0.textColor = .systemGray2
        $0.font = .systemFont(ofSize: 10.5, weight: .medium)
        $0.textAlignment = .left
    }
    
    fileprivate lazy var bottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .bottom
        $0.distribution = .equalCentering
    }
    
    fileprivate lazy var topStackView = UIStackView().then {
        $0.spacing = 8
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalCentering
    }
    
    lazy var statusLabel = UILabel().then {
        $0.textColor = .systemBrown
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textAlignment = .left
    }
    
    lazy var idLabel = UILabel().then {
        $0.textColor = .darkText
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
    }
    
    override func bindUI() {
        let data = PublishSubject<TodoCardModel>()
        
        data.observe(on: MainScheduler.instance)
            .bind(to: self.rx.cellData)
            .disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.disposeBag = DisposeBag()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
}
