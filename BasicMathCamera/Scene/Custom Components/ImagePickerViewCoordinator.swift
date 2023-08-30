//
//  ImagePickerViewCoordinator.swift
//  BasicMathCamera
//
//  Created by Jaime Jazareno IV on 8/30/23.
//

import SwiftUI

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  var didSelectImage: ((UIImage) -> Void)?
  var shouldClose: (() -> Void)?

  init(shouldClose: (() -> Void)?, didSelectImage: ((UIImage) -> Void)?) {
    self.didSelectImage = didSelectImage
    self.shouldClose = shouldClose
  }

  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      didSelectImage?(image)
    }
    shouldClose?()
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    shouldClose?()
  }
}
