import SwiftUI

public struct NBSelect<T: Hashable>: View {
    @Environment(\.nbTheme) var theme: NBTheme
    
    let title: String
    @Binding var selection: T
    let options: [T]
    let optionLabel: (T) -> String
    
    @State private var isExpanded = false
    
    public init(
        title: String = "Select",
        selection: Binding<T>,
        options: [T],
        optionLabel: @escaping (T) -> String = { "\($0)" }
    ) {
        self.title = title
        self._selection = selection
        self.options = options
        self.optionLabel = optionLabel
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text(optionLabel(selection).isEmpty ? title : optionLabel(selection))
                        .foregroundStyle(theme.mainText)
                        .font(.body)
                        .bold()
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .foregroundStyle(theme.mainText)
                }
                .padding(theme.padding)
                .background(theme.main)
                .overlay(
                    Rectangle()
                        .stroke(theme.border, lineWidth: theme.borderWidth)
                )
                .nbBox(elevated: true)
            }
            .buttonStyle(.plain)
            .zIndex(10) // High zIndex for the trigger
            
            // Floating Dropdown Content
            if isExpanded {
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(options, id: \.self) { option in
                                Button {
                                    selection = option
                                    withAnimation {
                                        isExpanded = false
                                    }
                                } label: {
                                    HStack {
                                        Text(optionLabel(option))
                                            .foregroundStyle(theme.mainText)
                                            .bold()
                                        
                                        Spacer()
                                        
                                        if selection == option {
                                            Image(systemName: "checkmark")
                                                .foregroundStyle(theme.mainText)
                                        }
                                    }
                                    .padding(theme.padding)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                        Rectangle()
                                            .fill(selection == option ? theme.bw.opacity(0.5) : theme.main) // Different highlight
                                    )
                                    .overlay(
                                        Rectangle()
                                            .frame(height: theme.borderWidth)
                                            .foregroundStyle(theme.border),
                                        alignment: .bottom
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .frame(maxHeight: 200)
                }
                .background(theme.main)
                .overlay(
                    Rectangle()
                        .stroke(theme.border, lineWidth: theme.borderWidth)
                )
                .nbBox(elevated: true)
                .padding(.top, 4)
                .transition(.opacity.combined(with: .move(edge: .top)))
                // Use geometry reader logic or alignment guide in real apps for positioning, 
                // but standard layout flow here effectively pushes it down if not overlaid.
                // To make it float OVER content below:
            }
        }
        // To truly float over subsequent siblings in a VStack, we need this whole component to have high zIndex
        // or use .overlay on the View that contains this. 
        // But for simplicity in this V1, let's keep it in flow (pushing content) which is robust on mobile.
        // Making it overlay requires coordinating coordinate spaces which is fragile without GeometryReader everywhere.
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var selectedFruit = "Apple"
    let fruits = ["Apple", "Banana", "Orange", "Grape", "Strawberry", "Watermelon"]
    
    ZStack(alignment: .top) {
        NBSelect(selection: $selectedFruit, options: fruits)
            .padding()
    }
    .frame(maxHeight: .infinity, alignment: .top)
}