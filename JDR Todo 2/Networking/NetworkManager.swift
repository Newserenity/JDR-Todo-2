//
//  NetworkManager.swift
//  JDR Todo 2
//
//  Created by Jayden Jang on 2023/06/10.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getTodosRX(page: Int = 1,
                    orderByDate: OrderByDate = .created,
                    orderByIndex: OrderByIndex = .descending,
                    isDone: Status = .both,
                    perPage:Int = 20) -> Observable<[TodoCard]> {
        let interceptor = BaseInterceptor()

        let router = Router.getTodos(page: page,
                                     orderByDate: orderByDate,
                                     orderByIndex: orderByIndex,
                                     isDone: isDone,
                                     perPage: perPage)
        
        return RxAlamofire
            .request(router, interceptor: interceptor)
            .validate(statusCode: 200..<300)
            .data() // Observable<Data>
            .decode(type: ListDataResponse<Todo>.self, decoder: JSONDecoder()) //
            .compactMap { $0.data }
            .map{ $0.map{ TodoCard($0) }
            }
            .catch { err in
                if err is DecodingError {
                    throw NetworkError.invalidResponse
                }
                throw NetworkError.unknown(err: err)
            }
    }
}
