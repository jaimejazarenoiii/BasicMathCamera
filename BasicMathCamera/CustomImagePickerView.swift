//
//  CustomImagePickerView.swift
//  BasicMathCamera
//
//  Created by Jaime Jazareno IV on 8/30/23.
//

import SwiftUI
import UIKit

struct CustomImagePickerView: UIViewControllerRepresentable {
  var sourceType: UIImagePickerController.SourceType = .camera
  var shouldClose: (() -> Void)?
  var didSelectImage: ((UIImage) -> Void)?

  func makeCoordinator() -> ImagePickerViewCoordinator {
    ImagePickerViewCoordinator(shouldClose: shouldClose, didSelectImage: didSelectImage)
  }

  func makeUIViewController(context: Context) -> UIImagePickerController {
    let pickerController = UIImagePickerController()
    pickerController.sourceType = sourceType
    pickerController.delegate = context.coordinator
    return pickerController
  }

  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    // Nothing to update here
  }
}
