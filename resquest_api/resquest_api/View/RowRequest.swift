import SwiftUI

struct RowRequest: View {
    var datum: DatumModel
    
    var body: some View {
        HStack {
            Image("").setImage(image: datum.image, width: 80, height: 100)
            VStack(alignment: .leading, spacing: 5) {
                Text(datum.name)
                    .font(.callout)
                    .bold()
                Text(datum.gender.rawValue)
                    .font(.caption)
                    .fontWeight(.light)
                Text(datum.location.name)
                    .font(.caption)
                    .fontWeight(.light)
            }
        }
    }
}
