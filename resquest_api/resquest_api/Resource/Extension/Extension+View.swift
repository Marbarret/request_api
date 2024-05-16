import SwiftUI

extension View {
  func setImage(image: String?, width: CGFloat, height: CGFloat) -> some View {
      self.modifier(ImageModifier(path: image ?? "", width: width, height: height))
  }
}
