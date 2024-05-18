import SwiftUI

struct RowRequest: View {
    var datum: DatumModel
    
    var body: some View {
        VStack {
            Image("").setImage(image: datum.image)
//            VStack(alignment: .leading, spacing: 5) {
//                Text(datum.name)
//                    .font(.callout)
//                    .bold()
//                Text(datum.gender.rawValue)
//                    .font(.caption)
//                    .fontWeight(.light)
//                Text(datum.location.name)
//                    .font(.caption)
//                    .fontWeight(.light)
//            }
        }
    }
}
