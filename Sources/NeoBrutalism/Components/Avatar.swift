import SwiftUI

public struct NBAvatar: View {
    @Environment(\.nbTheme) var theme: NBTheme

    let url: URL?
    let image: Image?
    let fallback: String

    public init(url: URL? = nil, image: Image? = nil, fallback: String) {
        self.url = url
        self.image = image
        self.fallback = fallback
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(theme.bw)
            
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if let url = url {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else if phase.error != nil {
                        Text(fallback)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(theme.text)
                    } else {
                        // Loading state
                        ProgressView()
                    }
                }
            } else {
                Text(fallback)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(theme.text)
            }
        }
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(theme.border, lineWidth: theme.borderWidth)
        )
        .frame(width: 40, height: 40) // Default size matching Web "size-10" (2.5rem = 40px)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    HStack(spacing: 20) {
        // Image Asset
        NBAvatar(image: Image(systemName: "person.fill"), fallback: "NB")
        
        // URL
        NBAvatar(url: URL(string: "https://github.com/shadcn.png"), fallback: "CN")
        
        // Fallback
        NBAvatar(fallback: "JD")
    }
    .padding()
}
