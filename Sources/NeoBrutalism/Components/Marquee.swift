import SwiftUI

public struct NBMarquee<Content: View>: View {
    @Environment(\.nbTheme) var theme: NBTheme
    var speed: Double
    var content: () -> Content
    
    @State private var offset: CGFloat = 0
    @State private var contentWidth: CGFloat = 0
    @State private var containerWidth: CGFloat = 0
    
    public init(speed: Double = 50, @ViewBuilder content: @escaping () -> Content) {
        self.speed = speed
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { geo in
            let cWidth = geo.size.width
            
            HStack(spacing: 0) {
                content()
                    .fixedSize() // Ensure it takes its natural width
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    contentWidth = proxy.size.width
                                }
                                .onChange(of: proxy.size.width) { _, newValue in
                                    contentWidth = newValue
                                }
                        }
                    )
                
                // Duplicate content for loop
                if contentWidth > 0 {
                    content()
                        .fixedSize()
                    
                    // Add more if needed to fill screen
                    if contentWidth < cWidth {
                        content()
                            .fixedSize()
                    }
                }
            }
            .offset(x: offset)
            .onAppear {
                containerWidth = cWidth
                startAnimation()
            }
            .onChange(of: contentWidth) { _, _ in
                startAnimation()
            }
        }
        .frame(height: 60)
        .background(theme.background)
        .overlay(
            VStack {
                Rectangle().frame(height: theme.borderWidth).foregroundStyle(theme.border)
                Spacer()
                Rectangle().frame(height: theme.borderWidth).foregroundStyle(theme.border)
            }
        )
        .clipped()
    }
    
    private func startAnimation() {
        guard contentWidth > 0 else { return }
        
        // Reset
        offset = 0
        
        // Duration = distance / speed
        let duration = Double(contentWidth) / speed
        
        withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
            offset = -contentWidth
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    NBMarquee(speed: 40) {
        HStack(spacing: 20) {
            Text("BREAKING NEWS: NEO-BRUTALISM TAKES OVER IOS")
                .font(.title3)
                .bold()
            
            Image(systemName: "star.fill")
            
            Text("SWIFTUI JUST GOT BOLDER")
                .font(.title3)
                .bold()
                
            Image(systemName: "bolt.fill")
        }
        .padding(.horizontal, 20)
    }
}