import SwiftUI

struct EpisodeView: View {
    @EnvironmentObject var viewModel: EpisodeViewModel
    
    var body: some View {
        List {
//            ForEach(viewModel.data) { ep in
//                RowEpisode(title: ep.name, seasonAndEp: ep.episode)
//            }
        }
    }
}

struct RowEpisode: View {
    var title: String
    var seasonAndEp: String
    
    var body: some View {
        HStack {
            VStack {
                Text(title)
                    .foregroundColor(.black)
                    .bold()
                
                Text(seasonAndEp)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
        .padding()
    }
}
