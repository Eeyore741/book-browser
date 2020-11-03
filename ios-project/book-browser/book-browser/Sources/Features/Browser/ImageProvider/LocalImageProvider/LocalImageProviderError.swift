//
//  LocalImageProviderError.swift
//  book-browser
//
//  Created by Vitalii Kuznetsov on 02/11/2020.
//  Copyright © 2020 Vitalii Kuznetsov. All rights reserved.
//

import Foundation

/// Enum type wrapping error cases of `LocalImageProvider` type
enum LocalImageProviderError: Error {
    case missingImageResource
}
