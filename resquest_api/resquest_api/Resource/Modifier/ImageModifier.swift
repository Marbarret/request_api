import SwiftUI

struct ImageModifier: ViewModifier {
  var path: String?

  init(path: String?) {
    self.path = path
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
                    .scaledToFit()
            case .failure:
                Text("No image")
            default:
                EmptyView()
            }
        }
    }
}
