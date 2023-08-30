//
//  BasicMathCameraApp.swift
//  BasicMathCamera
//
//  Created by Jaime Jazareno IV on 8/30/23.
//

import ComposableArchitecture
import SwiftUI

@main
struct BasicMathCameraApp: App {
  var body: some Scene {
    WindowGroup {
      ImageComputerView(
        store: Store(initialState: ImageComputerFeature.State()) {
          ImageComputerFeature()
        }
      )
    }
  }
}
