//
//  String+Localization.swift
//  Common
//
//  Created by Victor . on 18/11/21.
//

import Foundation


extension String {
  public func localized(identifier: String) -> String {
    let bundle = Bundle(identifier: identifier) ?? .main
    return bundle.localizedString(forKey: self, value: nil, table: nil)
  }
}
