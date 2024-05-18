import SwiftUI

extension View {
  func setImage(image: String?) -> some View {
      self.modifier(ImageModifier(path: image ?? ""))
  }
}
