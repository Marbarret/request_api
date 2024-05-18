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
        GeometryReader { reader in
            ZStack(alignment: .center) {
                ForEach(viewModel.data) { data in
                    let index = data.id
                    ZStack(alignment: .topLeading) {
                        Image("").setImage(image: data.image)
                            .scaledToFill()
                            .frame(width: screenWidth * widthScale, height: cardHeight)
                            .scaleEffect(x: cardScale(for: index), y: cardScale(for: index))
                            .clipped()
                        
                        VStack(alignment: .leading, spacing: 10) {
                              Text(data.name)
                                .font(.title2)
                                .foregroundColor(.white)
                            }
                            .padding(20)
                            .background(Color.black.opacity(0.5))
                    }
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
                    
                } //ForEach
                .onAppear {
                    screenWidth = reader.size.width
                    cardHeight = screenWidth * widthScale * cardAspectRatio
                    
                }
                .offset(x: 16, y: 30)
            }// ZStack
            .onAppear {
                Task {
                    await viewModel.getData(page: 19)
                }
            }
        }//GeometryReader
        .frame(height: 280)
        
    }
    
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


struct CardView: View {
    let data: DatumModel
    let index: Int
    
    var body: some View {
        VStack {
            Text(data.name)
            Text("Index: \(index)")
        }
    }
}
