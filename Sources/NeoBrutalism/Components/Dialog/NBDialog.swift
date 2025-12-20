import SwiftUI

public extension View {
    func nbDialog<Content>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View {
        modifier(NBDialogModifier(isPresented: isPresented, dialogContent: content))
    }
}

struct NBDialogModifier<DialogContent>: ViewModifier where DialogContent: View {
    @Environment(\.nbTheme) var theme: NBTheme
    @Binding var isPresented: Bool
    let dialogContent: DialogContent

    init(isPresented: Binding<Bool>, @ViewBuilder dialogContent: () -> DialogContent) {
        _isPresented = isPresented
        self.dialogContent = dialogContent()
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
                
                // Dialog Content
                dialogView
                    .transition(.scale(scale: 0.95).combined(with: .opacity))
                    .zIndex(101)
            }
        }
    }
    
    var dialogView: some View {
        VStack(spacing: 0) {
            dialogContent
        }
        .padding(theme.xlpadding)
        .background(theme.background)
        .overlay(
            Rectangle()
                .stroke(theme.border, lineWidth: theme.borderWidth)
        )
        .nbBox(elevated: true)
        .frame(maxWidth: 350) // Restrict width like Web "max-w-lg" (but narrower for mobile default)
        .padding()
    }
}

// Helper components for structure
public struct NBDialogHeader<Content: View>: View {
    let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 16)
    }
}

public struct NBDialogFooter<Content: View>: View {
    let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        HStack {
            Spacer()
            content
        }
        .padding(.top, 16)
    }
}

public struct NBDialogTitle: View {
    @Environment(\.nbTheme) var theme
    let text: String
    
    public init(_ text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .font(.title3)
            .bold()
            .foregroundStyle(theme.mainText)
    }
}

public struct NBDialogDescription: View {
    @Environment(\.nbTheme) var theme
    let text: String
    
    public init(_ text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .font(.subheadline)
            .foregroundStyle(theme.text)
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var showDialog = false
    
    ZStack {
        Button("Show Dialog") {
            withAnimation { showDialog = true }
        }
        .buttonStyle(.neoBrutalism())
    }
    .nbDialog(isPresented: $showDialog) {
        NBDialogHeader {
            NBDialogTitle("Edit Profile")
            NBDialogDescription("Make changes to your profile here. Click save when you're done.")
        }
        
        VStack(spacing: 12) {
            TextField("Name", text: .constant("Pedro Duarte"))
                .textFieldStyle(.neoBrutalism)
            TextField("Username", text: .constant("@peduarte"))
                .textFieldStyle(.neoBrutalism)
        }
        
        NBDialogFooter {
            Button("Save Changes") {
                withAnimation { showDialog = false }
            }
            .buttonStyle(.neoBrutalism())
        }
    }
}
