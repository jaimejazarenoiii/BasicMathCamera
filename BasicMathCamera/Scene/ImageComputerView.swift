//
//  ImageComputerView.swift
//  BasicMathCamera
//
//  Created by Jaime Jazareno IV on 8/30/23.
//

import ComposableArchitecture
import SwiftUI

struct ImageComputerView: View {
  let store: StoreOf<ImageComputerFeature>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(alignment: .leading) {
        Text("Input: \(viewStore.state.inputText)")
        Text("Result: \(viewStore.state.total)")
        Spacer()
        Button {
          viewStore.send(.showUploadMode)
        } label: {
          Text("Add input")
        }
        .buttonStyle(.borderedProminent)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
      .padding()
      .foregroundColor(.white)
      .background(
        viewStore.state.redTheme ? Color.red : Color.green
      )
      .sheet(isPresented: viewStore.binding(get: \.shouldPresentUploadMode,
                                            send: ImageComputerFeature.Action.hideUploadMode)) {
        CustomImagePickerView(
          sourceType: viewStore.state.cameraMode ? .camera : .photoLibrary,
          shouldClose: {
            viewStore.send(.hideUploadMode)
          },
          didSelectImage: { image in
            viewStore.send(.set(image: image))
            viewStore.send(.hideUploadMode)
          }
        )
        .ignoresSafeArea(.all)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ImageComputerView(
      store: Store(initialState: ImageComputerFeature.State()) {
        ImageComputerFeature()
      }
    )
  }
}
