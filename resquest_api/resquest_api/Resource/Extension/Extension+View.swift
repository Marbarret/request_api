import SwiftUI

extension View {
    func setImage(image: String?) -> some View {
        self.modifier(ImageModifier(path: image ?? ""))
    }
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
