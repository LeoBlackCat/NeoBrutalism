import SwiftUI

extension EnvironmentValues {
    @Entry var nbCollapsibleDidToggle: NBCollapsibleDidToggle = {}
    @Entry var nbCollapsibleIsExpanded: Bool = false
}

public struct NBCollapsibleContent<Content>: View where Content: View {
    @Environment(\.nbCollapsibleIsExpanded) var isExpanded

    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        if isExpanded {
            content
        }
    }
}

public struct NBCollapsibleTrigger<Trigger>: View where Trigger: View {
    @Environment(\.nbCollapsibleDidToggle) var collapsibleDidToggle

    let trigger: Trigger

    public init(@ViewBuilder trigger: () -> Trigger) {
        self.trigger = trigger()
    }

    public var body: some View {
        trigger
            .contentShape(Rectangle())
            .onTapGesture {
                collapsibleDidToggle()
            }
    }
}

typealias NBCollapsibleDidToggle = () -> Void
public struct NBCollapsible<Content>: View where Content: View {
    @Environment(\.nbTheme) var theme: NBTheme

    typealias CollapsibleDidToggle = () -> Void

    @Binding var isExpanded: Bool
    let content: Content

    public init(isExpanded: Binding<Bool>,
                @ViewBuilder content: () -> Content)
    {
        _isExpanded = isExpanded
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: theme.smspacing) {
            content
                .environment(\.nbCollapsibleIsExpanded, isExpanded)
                .environment(\.nbCollapsibleDidToggle) { isExpanded.toggle() }
        }
    }
}

@available(iOS 18.0, *)
#Preview(traits: .modifier(NBPreviewHelper())) {
    @Previewable @State var isExapanded = true

    VStack {
        NBCollapsible(isExpanded: $isExapanded) {
            NBFlatCard {
                HStack {
                    Text("Some")
                    Spacer()
                    NBCollapsibleTrigger {
                        Image(systemName: "chevron.up.chevron.down.square.fill")
                    }
                }
            }

            NBFlatCard(type: .neutral) {
                Text("another card")
            }

            NBCollapsibleContent {
                NBFlatCard(type: .default) {
                    Text("Content")
                    Text("Content")
                    Text("Content")
                }
            }
        }
    }
}
