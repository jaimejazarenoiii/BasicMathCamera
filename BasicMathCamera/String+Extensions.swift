//
//  String+Extensions.swift
//  BasicMathCamera
//
//  Created by Jaime Jazareno IV on 8/31/23.
//

import Foundation

extension String {
  func stringsMatchingRegularExpression(expression regex: String) -> [String] {
    let regex = try? NSRegularExpression(pattern: regex)
    let results = regex?.matches(in: self,
                                range: NSRange(self.startIndex..., in: self))
    return results?.map {
      String(self[Range($0.range, in: self)!])
    } ?? []
  }
}
