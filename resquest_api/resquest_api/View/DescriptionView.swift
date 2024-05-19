import SwiftUI

struct DescriptionView: View {
    var data: DatumModel
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading) {
                Text(data.name)
                    .font(.callout)
                    .bold()
                    .foregroundColor(.black)
                
                Divider()
                    .padding(5)
                
                Text(data.gender.rawValue)
                    .font(.caption)
                    .foregroundColor(.black)
                
                Text(data.location.name)
                    .font(.caption)
                    .foregroundColor(.black)
            }
            Spacer()
            Text(data.status.rawValue)
                .foregroundColor(Color.white)
                .font(.caption)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black)
                )
                .offset(x: -5,y: -45)
        }
    }
}
