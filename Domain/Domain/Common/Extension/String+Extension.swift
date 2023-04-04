//
//  String+Extension.swift
//  Domain
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 30/03/23.
//

import Foundation
extension String {
    func localized(commet: String = "") -> String {
        let bundle = Bundle(identifier: "com.jaime.uribe.Domain")
        return NSLocalizedString(self, bundle: bundle!, comment: commet)
    }
}
