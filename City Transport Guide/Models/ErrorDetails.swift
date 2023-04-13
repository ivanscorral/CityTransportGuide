//
//  ErrorDetails.swift
//  City Transport Guide
//
//  Created by Ivan Sanchez on 13/4/23.
//

import Foundation

struct APIError: Codable, Error {
    let timestamp: Int64
    let euid: String
    let type: String
    let errors: [ErrorDetails]
}

struct ErrorDetails: Codable {
    let id: String
    let message: String
    let level: String
    let category: String
    let categoryAlt: String?
    let args: [String]
}
