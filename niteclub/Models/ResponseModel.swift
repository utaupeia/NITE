//
//  ResponseModel.swift
//  niteclub
//
//  Created by Andrii Beskostyi on 15.12.2023.
//

import Foundation

struct ResponseModel<Model: Codable>: Codable {
    let result: Model
}
