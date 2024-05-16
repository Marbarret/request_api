import SwiftUI

struct ImageModifier: ViewModifier {
  var path: String?
  var width: CGFloat
  var height: CGFloat

  init(path: String?, width: CGFloat, height: CGFloat) {
    self.path = path
    self.width = width
    self.height = height
  }
    
    func body(content: Content) -> some View {
        AsyncImage(url: URL(string: path ?? "")) { load in
            switch load {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .cornerRadius(10)
                    .frame(width: self.width, height: self.height)
                    .scaledToFit()
            case .failure:
                Text("No image")
            default:
                EmptyView()
            }
        }
    }
}
