//
//  MyErrors.swift
//  pulldown-to-refresh
//
//  Created by Sachin Daingade on 21/12/21.
//

import Foundation

enum MyErrors: Error, LocalizedError, Identifiable {
    case invalidCredentials
    case invalidAPICall
    
    var id: String {
        self.localizedDescription
    }
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return NSLocalizedString("Please try again", comment: "")
        case .invalidAPICall:
          return NSLocalizedString("Please try again", comment: "")
        }
    }
}
