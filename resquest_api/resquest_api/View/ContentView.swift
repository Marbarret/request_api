import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State var cardHeight: CGFloat = 0
    @State var dragOffset: CGFloat = 0
    @State var screenWidth: CGFloat = 0
    @State var activCardIndex = 0
    let widthScale = 0.75
    let cardAspectRatio = 1.5
    
    var body: some View {
        NavigationStack {
            GeometryReader { reader in
                ZStack(alignment: .center) {
                    forEachData
                        .onAppear {
                            screenWidth = reader.size.width
                            cardHeight = screenWidth * widthScale * cardAspectRatio
                        }
                        .offset(x: 16, y: -15)
                }// ZStack
                .onAppear {
                    Task {
                        await viewModel.getData(page: 1)
                    }
                }
            }//GeometryReader
            .navigationTitle("Rick and Morty")
        }
    }
}

extension ContentView {
    
    var forEachData: some View {
        ForEach(viewModel.data) { data in
            let index = data.id
            ZStack(alignment: .bottom) {
                if index == activCardIndex {
                    moreInfoComp
                }
                
                Image("").setImage(image: data.image)
                    .scaledToFill()
                    .frame(width: screenWidth * widthScale, height: cardHeight)
                    .scaleEffect(x: cardScale(for: index), y: cardScale(for: index))
                    .clipped()
                
                if index == activCardIndex {
                    DescriptionView(data: data)
                        .padding()
                        .frame(width: screenWidth * widthScale, height: 90)
                        .background(Color.white.opacity(0.7))
                }
            }
            .offset(y: 100)
            .shadow(radius: 12)
            .offset(x: cardOffSet(for: index))
            .scaleEffect(x: cardScale(for: index), y: cardScale(for: index))
            .zIndex(-Double(index))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.dragOffset = value.translation.width
                    }.onEnded { value in
                        let thresh = screenWidth * 0.2
                        
                        withAnimation {
                            if value.translation.width < -thresh {
                                activCardIndex = min(activCardIndex + 1, viewModel.data.count - 1)
                            } else if value.translation.width > thresh {
                                activCardIndex = max(activCardIndex - 1, 0)
                            }
                        }
                        withAnimation {
                            dragOffset = 0
                        }
                    }
            )
        }
    }
    
    var moreInfoComp: some View {
        HStack {
            Text("More Information's")
                .font(.caption)
                .foregroundColor(Color.black)
                .padding()
            
            Spacer()
            Divider()
                .padding(.vertical, 5)
            
            Image(systemName: "arrowtriangle.right.circle.fill")
                .foregroundColor(Color.black)
                .padding()
        }
        .frame(width: 250, height: 50)
        .background(Color.white)
        .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
        .offset(y: 50)
    }
}

// Functions
extension ContentView {
    func cardOffSet(for index: Int) -> CGFloat {
        let adjustedIndex = index - activCardIndex
        let cardSpacing: CGFloat = 60 / cardScale(for: index)
        let initialOffset = cardSpacing * CGFloat(adjustedIndex)
        
        let progress = min(abs(dragOffset)/(screenWidth/2), 1)
        let maxCardMovement = cardSpacing
        
        if adjustedIndex < 0 {
            if dragOffset > 0 && index == activCardIndex - 1 {
                
                let distanceToMove = (initialOffset + screenWidth) * progress
                return -screenWidth + distanceToMove
            } else {
                return -screenWidth
            }
        } else if index > activCardIndex {
            let distanceToMove = progress * maxCardMovement
            return initialOffset - (dragOffset < 0 ? distanceToMove : -distanceToMove)
        } else {
            if dragOffset < 0 {
                return dragOffset
            } else {
                let distanceToMove = maxCardMovement * progress
                return initialOffset - (dragOffset < 0 ? distanceToMove : -distanceToMove)
            }
        }
    }
    
    func cardScale(for index: Int, proportion: CGFloat = 0.2) -> CGFloat {
        let adjustedIndex = index - activCardIndex
        if index >= activCardIndex {
            let progress = min(abs(dragOffset)/(screenWidth/2), 1)
            return 1 - proportion * CGFloat(adjustedIndex) + (dragOffset < 0 ? proportion * progress : -proportion * progress)
        }
        return 1
    }
}
