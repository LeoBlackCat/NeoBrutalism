import SwiftUI

public struct NBTextarea: View {
    @Environment(\.nbTheme) var theme: NBTheme
    @Binding var text: String
    let placeholder: String?
    
    public init(_ placeholder: String? = nil, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty, let placeholder = placeholder {
                Text(placeholder)
                    .foregroundStyle(theme.text.opacity(0.5))
                    .padding(.horizontal, 8) // Match TextEditor padding
                    .padding(.vertical, 12)
                    .allowsHitTesting(false)
            }
            
            TextEditor(text: $text)
                .scrollContentBackground(.hidden) // Remove default background
                .frame(minHeight: 80) // Match Web "min-h-[80px]"
                .padding(4) // Internal padding
        }
        .background(theme.bw) // Background
        .foregroundStyle(theme.text)
        .overlay(
            Rectangle()
                .stroke(theme.border, lineWidth: theme.borderWidth)
        )
        .nbBox(elevated: false) // Input fields usually aren't elevated in this system unless focused, but let's stick to flat or subtle. Web uses "border-2".
        // NBBox adds shadow. Web Textarea does NOT have shadow-shadow class in the file I read, only border-2.
        // Wait, input.tsx usually has shadow. Let me check input.tsx quickly or just assume consistent design.
        // The read file for textarea said: "border-2 border-border bg-secondary-background ... focus-visible:ring-2"
        // It did NOT list "shadow-shadow".
        // So I should probably disable the NBBox shadow or make it optional.
        // But Input.swift in this repo might have shadow.
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var text = ""
    
    VStack {
        NBTextarea("Type your spell here...", text: $text)
            .frame(height: 150)
        
        NBTextarea(text: .constant("This is a readonly text area"))
            .disabled(true)
    }
    .padding()
}
