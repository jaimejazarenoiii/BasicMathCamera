//
//  ImageTextBasicMathComputerService.swift
//  BasicMathCamera
//
//  Created by Jaime Jazareno IV on 8/30/23.
//

import UIKit
import Vision

class ImageTextBasicMathComputerService {
  let pattern = "([0-9]+[\\+\\-\\*\\/]{1}[0-9])"
  let operators = "([\\+\\-\\*\\/]{1})"

  public static let shared: ImageTextBasicMathComputerService = ImageTextBasicMathComputerService()

  private init() {}

  func calculateFrom(image: UIImage) -> (operands: [String], mathOperator: String, total: String)? {
    guard let foundPattern = translate(image: image)?.lowercased() else { return nil }
    guard let mathOperator = foundPattern.stringsMatchingRegularExpression(expression: operators).first else { return nil }
    let operands = foundPattern.components(separatedBy: mathOperator)

    guard let operand1 = operands.first,
          let operand2 = operands.last,
          let val1 = Double(operand1),
          let val2 = Double(operand2) else { return nil }
    var total: Double = 0
    switch mathOperator {
    case "+": total = val1 + val2
    case "-": total = val1 - val2
    case "*": total = val1 * val2
    case "x": total = val1 * val2
    case "/": total = val1 / val2
    default: break
    }
    return (operands: [operand1, operand2], mathOperator: mathOperator, total: String(total))
  }

  private func translate(image: UIImage) -> String? {
    guard let cgImage = image.cgImage else { return nil }
    var foundText: String? = nil
    let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])

    let request = VNRecognizeTextRequest { [weak self] request, error in
      guard let self else { return }
      guard let observations = request.results as? [VNRecognizedTextObservation],
            error == nil else {
        return
      }
      let text = observations.compactMap { observation in
        observation.topCandidates(1).first?.string ?? ""
      }.joined(separator: ", ").filter { !$0.isWhitespace }
      guard let textMatchesPattern = text.stringsMatchingRegularExpression(expression: self.pattern).first else { return }
      foundText = textMatchesPattern
    }
    request.recognitionLevel = VNRequestTextRecognitionLevel.accurate

    try? handler.perform([request])
    return foundText
  }
}

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
