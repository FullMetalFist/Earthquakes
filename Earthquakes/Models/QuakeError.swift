//
//  QuakeError.swift
//  Earthquakes-iOS
//
//  Created by Michael Vilabrera on 5/23/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation

enum QuakeError: Error {
    case missingData
    case networkError
}

extension QuakeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("Found and will discard a quake missing a valid code, magnitude, place, or time.", comment: "")
        case .networkError:
            return NSLocalizedString("Error connecting to network", comment: "")
        }
    }
}
