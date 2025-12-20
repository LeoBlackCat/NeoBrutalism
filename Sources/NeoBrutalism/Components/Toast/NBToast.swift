import SwiftUI

public struct NBToastModel: Identifiable, Equatable {
    public let id = UUID()
    public let title: String
    public let message: String?
    public let type: NBToastType
    public let duration: TimeInterval
    
    public init(title: String, message: String? = nil, type: NBToastType = .normal, duration: TimeInterval = 3.0) {
        self.title = title
        self.message = message
        self.type = type
        self.duration = duration
    }
}

public enum NBToastType {
    case normal
    case success
    case error
}

@MainActor
public class NBToastManager: ObservableObject {
    @Published public var toast: NBToastModel?
    
    public init() {}
    
    public func show(title: String, message: String? = nil, type: NBToastType = .normal, duration: TimeInterval = 3.0) {
        withAnimation(.spring()) {
            toast = NBToastModel(title: title, message: message, type: type, duration: duration)
        }
        
        if duration > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                if self.toast?.id == self.toast?.id { // Check if it's still the same toast
                    self.dismiss()
                }
            }
        }
    }
    
    public func dismiss() {
        withAnimation(.spring()) {
            toast = nil
        }
    }
}

struct NBToastView: View {
    let model: NBToastModel
    @Environment(\.nbTheme) var theme
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            icon
            
            VStack(alignment: .leading, spacing: 2) {
                Text(model.title)
                    .font(.headline)
                    .bold()
                
                if let message = model.message {
                    Text(message)
                        .font(.subheadline)
                }
            }
            
            Spacer()
        }
        .padding(theme.padding)
        .background(theme.background)
        .overlay(
            Rectangle()
                .stroke(theme.border, lineWidth: theme.borderWidth)
        )
        .nbBox(elevated: true)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var icon: some View {
        switch model.type {
        case .normal:
            Image(systemName: "info.circle.fill")
                .font(.title2)
                .foregroundStyle(theme.text)
        case .success:
            Image(systemName: "checkmark.circle.fill")
                .font(.title2)
                .foregroundStyle(.green)
        case .error:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.title2)
                .foregroundStyle(.red)
        }
    }
}

public struct NBToastModifier: ViewModifier {
    @ObservedObject var manager: NBToastManager
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            
            if let model = manager.toast {
                NBToastView(model: model)
                    .padding(.bottom, 50)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(9999)
                    .onTapGesture {
                        manager.dismiss()
                    }
            }
        }
    }
}

public extension View {
    func nbToast(manager: NBToastManager) -> some View {
        self.modifier(NBToastModifier(manager: manager))
    }
}
