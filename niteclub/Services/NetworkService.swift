///Users/beskostyi.ad/Workspace/NITE/niteclub/Services
//  NetworkService.swift
//  niteclub
//
//  Created by Andrii Beskostyi on 15.12.2023.
//

import Foundation
import Combine

extension NetworkService {
    enum NetworkError: Error {
        case norResponse
        case unsuccess(Int)
        case decoding(Error)
    }
}

class NetworkService {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    func dataTaskPublisher<T: Codable>(for request: URLRequest) -> AnyPublisher<T, NetworkError> {
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.norResponse
                }
                guard (200..<300).contains(httpResponse.statusCode) else {
                    throw NetworkError.unsuccess(httpResponse.statusCode)
                }
                
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                if let error = error as? NetworkError {
                    return error
                } else {
                    let customError = NetworkError.decoding(error)
                    return customError
                }
            }
            .eraseToAnyPublisher()
    }
}
