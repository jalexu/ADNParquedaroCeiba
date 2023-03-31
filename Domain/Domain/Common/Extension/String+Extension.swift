//
//  String+Extension.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 30/03/23.
//

import Foundation
extension String {
    func localized(commet: String = "") -> String {
        return NSLocalizedString(self, comment: commet)
    }
}
