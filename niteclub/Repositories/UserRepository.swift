//
//  UserRepository.swift
//  niteclub
//
//  Created by Andrii Beskostyi on 15.12.2023.
//

import Combine
import Foundation

extension UserRepository {
    enum RepositoryError: Error {
        case badUrl, network(Error)
    }
}

class UserRepository {
    static func getUser() -> AnyPublisher<ResponseModel<User>, RepositoryError> {
        guard let url = URL(string: "https://stg-niteclub.ci.gbksoft.space/rest/v1/user/current?expand=requests%2C%20requests.member%2C%20comments%2C%20comments.replies") else {
            return Fail(error: RepositoryError.badUrl).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Authorization"] = "Bearer user7"
        request.allHTTPHeaderFields = headers
        return NetworkService().dataTaskPublisher(for: request)
            .mapError { networkError -> RepositoryError in
                RepositoryError.network(networkError)
            }
            .eraseToAnyPublisher()
    }
}
