import SwiftUI

public extension View {
    func nbSheet<Content>(
        isPresented: Binding<Bool>,
        side: NBSheetSide = .right,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        modifier(NBSheetModifier(isPresented: isPresented, side: side, sheetContent: content))
    }
}

public enum NBSheetSide {
    case top, bottom, left, right
    
    var transitionEdge: Edge {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        case .left: return .leading
        case .right: return .trailing
        }
    }
    
    var alignment: Alignment {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        case .left: return .leading
        case .right: return .trailing
        }
    }
}

struct NBSheetModifier<SheetContent>: ViewModifier where SheetContent: View {
    @Environment(\.nbTheme) var theme: NBTheme
    @Binding var isPresented: Bool
    let side: NBSheetSide
    let sheetContent: SheetContent

    init(isPresented: Binding<Bool>, side: NBSheetSide, @ViewBuilder sheetContent: () -> SheetContent) {
        _isPresented = isPresented
        self.side = side
        self.sheetContent = sheetContent()
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                // Dimming Overlay
                theme.overlay
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            isPresented = false
                        }
                    }
                    .zIndex(100)
                
                // Sheet Content
                sheetView
                    .transition(.move(edge: side.transitionEdge))
                    .zIndex(101)
            }
        }
    }
    
    var sheetView: some View {
        ZStack(alignment: side.alignment) {
            
            // For placement
            Color.clear.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Drag Indicator / Header could go here
                
                // Content
                sheetContent
            }
            .padding(theme.padding)
            .background(theme.background)
            .overlay(
                Rectangle()
                    .stroke(theme.border, lineWidth: theme.borderWidth)
            )
            .nbBox(elevated: true) // Adds the hard shadow
            .frame(
                maxWidth: (side == .left || side == .right) ? 300 : .infinity,
                maxHeight: (side == .top || side == .bottom) ? 400 : .infinity
            )
            // Handle safe areas based on side
            .ignoresSafeArea(edges: (side == .bottom) ? .bottom : (side == .top ? .top : []))
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var showSheet = false
    @Previewable @State var side: NBSheetSide = .right
    
    ZStack {
        VStack(spacing: 20) {
            Text("Sheet Example")
                .font(.largeTitle)
                .bold()
            
            HStack {
                Button("Left") { side = .left; withAnimation { showSheet = true } }
                    .buttonStyle(.neoBrutalism())
                Button("Right") { side = .right; withAnimation { showSheet = true } }
                    .buttonStyle(.neoBrutalism())
            }
            HStack {
                Button("Top") { side = .top; withAnimation { showSheet = true } }
                    .buttonStyle(.neoBrutalism())
                Button("Bottom") { side = .bottom; withAnimation { showSheet = true } }
                    .buttonStyle(.neoBrutalism())
            }
        }
    }
    .nbSheet(isPresented: $showSheet, side: side) {
        VStack(alignment: .leading, spacing: 20) {
            Text("Edit Profile")
                .font(.title2)
                .bold()
            
            Text("Make changes to your profile here. Click save when you're done.")
            
            Button("Save Changes") {
                withAnimation { showSheet = false }
            }
            .buttonStyle(.neoBrutalism())
            .padding(.top)
            
            Spacer()
        }
        .padding()
    }
}
