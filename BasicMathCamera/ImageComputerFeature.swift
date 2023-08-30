//
//  ImageComputerFeature.swift
//  BasicMathCamera
//
//  Created by Jaime Jazareno IV on 8/30/23.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct ImageComputerFeature: Reducer {
  struct State: Equatable {
    @BindingState var shouldPresentUploadMode: Bool = false
    var total: String = ""
    var operand1: String = ""
    var operand2: String = ""
    var mathOperator: String = ""
    var cameraMode: Bool {
      ProcessInfo.processInfo.environment["MODE"] == "camera"
    }
    var redTheme: Bool {
      ProcessInfo.processInfo.environment["THEME"] == "red"
    }
    var inputText: String {
      operand1 + mathOperator + operand2
    }
  }

  enum Action: Equatable {
    case set(image: UIImage)
    case showUploadMode
    case hideUploadMode
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .set(let image):
        let value = ImageTextBasicMathComputerService.shared.calculateFrom(image: image)
        state.operand1 = value?.operands.first ?? ""
        state.operand2 = value?.operands.last ?? ""
        state.mathOperator = value?.mathOperator ?? ""
        state.total = value?.total ?? ""
        return .none
      case .showUploadMode:
        state.shouldPresentUploadMode = true
        return .none
      case .hideUploadMode:
        state.shouldPresentUploadMode = false
        return .none
      }
    }
  }
}
