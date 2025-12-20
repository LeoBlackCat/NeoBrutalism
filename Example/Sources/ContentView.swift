import NeoBrutalism
import SwiftUI

struct ThemeOption: Identifiable {
    let id = UUID()
    let name: String
    let theme: NBTheme
}

struct AccordionExampleView: View {
    var body: some View {
        NBAccordion {
            Text("Piertotum Locomotor")
        } content: {
            Text("Pratimo Jeevit Bhavh - प्रतिमा जीवित भाव")
        }

        NBAccordion {
            Text("Expecto Patronum")
        } content: {
            Text("Pitradev Sanrakshanam - पितृदेव संरक्षणम्")
        }
    }
}

struct CheckboxExampleView: View {
    @State var checkboxState = true

    var body: some View {
        Toggle(isOn: $checkboxState) {
            Spacer()
            Text(checkboxState ? "(Alohomora!)" : "(Colloportus!)")
        }
        .toggleStyle(.neoBrutalismChecklist)
        HStack {
            Toggle(isOn: .constant(true)) {}
                .disabled(true)
            Toggle(isOn: .constant(false)) {}
                .disabled(true)
            Spacer()
            Text("Petrificus Totalus!")
                .italic()
        }.toggleStyle(.neoBrutalismChecklist)
    }
}

struct SwitchExampleView: View {
    @State var switchState = true

    var body: some View {
        HStack {
            Toggle(isOn: .constant(true)) {}
            Toggle(isOn: .constant(false)) {}

            Divider().fixedSize()

            Toggle(isOn: $switchState) {
                Spacer()
                Text(switchState ? "(Lumos!)" : "(Nox!)")
                    .italic()
            }
        }.toggleStyle(.neoBrutalismSwitch)
    }
}

struct AlertExampleView: View {
    var body: some View {
        VStack(spacing: 18.0) {
            NBAlert {
                Text("The Chamber of Secrets has been opened. Enemies of the heir, beware!")
            } icon: {
                Image(systemName: "exclamationmark.triangle")
            } head: {
                Text("Warning")
            }

            NBAlert(type: .neutral) {
                Text("Dementors are nearby. Expecto Patronum!")
            } head: {
                Text("Caution")
            }
        }
    }
}

struct BadgeExampleView: View {
    var body: some View {
        HStack {
            NBBadge {
                Text("Gryffindor")
                    .font(.title3)
            }
            NBBadge(type: .neutral) {
                Text("Slytherin")
            }
        }
    }
}

struct ButtonExampleView: View {
    @State var counter: Int = 0

    var body: some View {
        HStack(spacing: 12.0) {
            Button {
                counter += 1
            } label: {
                Text("Accio")
            }.buttonStyle(.neoBrutalism())

            Button {
                counter += 1
            } label: {
                Text("Expelliarmus")
            }.buttonStyle(.neoBrutalism(variant: .reverse))

            Button {
                counter += 1
            } label: {
                Image(systemName: "wand.and.sparkles.inverse")
                    .bold()
            }.buttonStyle(.neoBrutalism(type: .neutral, variant: .reverse))
        }
        Text("(Spells Cast: \(counter))")
            .italic()
    }
}

struct CardExampleView: View {
    var body: some View {
        VStack(spacing: 28.0) {
            NBCard {
                Text("Hogwarts Letter")
            } main: {
                Text("You have been accepted to Hogwarts School of Witchcraft and Wizardry!")
            } footer: {
                Button {
                    // No-op
                } label: {
                    Text("Open Letter").frame(maxWidth: .infinity)
                }.buttonStyle(.neoBrutalism())
            }

            NBCard(type: .neutral) {
                Text("Quidditch Gear")
            } main: {
                Text("Get your broomstick, Quidditch robes, and golden snitch!")
            } footer: {
                HStack(spacing: 12.0) {
                    Button {
                        // No-op
                    } label: {
                        Text("Open Firebolt")
                    }.buttonStyle(.neoBrutalism(type: .neutral))

                    Spacer()

                    Button {
                        // No-op
                    } label: {
                        Text("Snitch")
                    }.buttonStyle(.neoBrutalism())
                }
            }
        }
    }
}

struct InputExampleView: View {
    @State var text: String = ""

    var body: some View {
        VStack {
            TextField("Input", text: .constant("Wingardium Leviosa"))
                .disabled(true)
                .textFieldStyle(.neoBrutalism)

            TextField("Enter your spell", text: $text)
                .textFieldStyle(.neoBrutalism)

            Text("(You just cast: \(text))")
                .italic()
        }
    }
}

struct ProgressExampleView: View {
    var body: some View {
        ProgressView(value: 0.7)
            .progressViewStyle(.neoBrutalism)
    }
}

struct SliderExampleView: View {
    @State var sliderValue: CGFloat = 0.0

    var body: some View {
        HStack {
            Text("\(sliderValue, specifier: "%.2f")")
                .frame(width: 50.0, alignment: .leading)
            NBSlider(value: $sliderValue)
        }
    }
}

struct RadioGroupExampleView: View {
    @State private var selectedSpell: Int = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text("Selected Spell: \(selectedSpell)")
                .font(.title3)

            NBRadioGroup(value: $selectedSpell) {
                VStack(alignment: .leading) {
                    NBRadioItem(value: 0) {
                        Text("Expelliarmus")
                    }
                    NBRadioItem(value: 1) {
                        Text("Lumos")
                    }
                    NBRadioItem(value: 2) {
                        Text("Wingardium Leviosa")
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct RoundSkeletonExampleView: View {
    var body: some View {
        VStack(spacing: 12.0) {
            NBFlatCard {
                NBRoundSkeleton()
            }
            .frame(width: 120, height: 120)
        }
    }
}

struct TextSkeletonExampleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            NBTextSkeleton()

            NBTextSkeleton()
                .frame(width: 120)
        }
    }
}

struct TabsExampleView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        VStack(spacing: 8.0) {
            Text("House Selection: \(selectedTab)")
                .font(.title3)

            NBTabs(selectedTabItem: $selectedTab) {
                NBTabsList {
                    NBTabsTrigger(tabItem: 0) { Image(systemName: "flame.fill") }
                    NBTabsTrigger(tabItem: 1) { Image(systemName: "lanyardcard.fill") }
                    NBTabsTrigger(tabItem: 2) { Image(systemName: "book.fill") }
                    NBTabsTrigger(tabItem: 3) { Image(systemName: "leaf.fill") }
                }
                NBFlatCard {
                    ZStack {
                        NBTabsContent(tabItem: 0) { Text("Bravery and Daring!") }
                        NBTabsContent(tabItem: 1) { Text("Cunning and Ambition!") }
                        NBTabsContent(tabItem: 2) { Text("Wisdom and Learning!") }
                        NBTabsContent(tabItem: 3) { Text("Loyalty and Hard Work!") }
                    }
                }
            }
        }
    }
}

struct CollapsibleExampleView: View {
    @State private var isExpanded: Bool = false

    var body: some View {
        VStack(spacing: 16.0) {
            Text("Room of Requirement")
                .font(.title)

            NBCollapsible(isExpanded: $isExpanded) {
                NBFlatCard {
                    HStack {
                        Text("Need something?")
                        Spacer()
                        NBCollapsibleTrigger {
                            Image(systemName: isExpanded ? "door.left.hand.open" : "door.left.hand.closed")
                        }
                    }
                }
                NBCollapsibleContent {
                    NBFlatCard(type: .neutral) {
                        Text("Here’s what you need!")
                    }
                }
            }
        }
    }
}

struct DrawerExampleView: View {
    @State private var isDrawerOpen: Bool = false

    var body: some View {
        VStack(spacing: 16.0) {
            Button {
                isDrawerOpen.toggle()
            } label: {
                Text("Open the Chamber")
            }.buttonStyle(.neoBrutalism())
        }
        .nbDrawer(isPresented: $isDrawerOpen) {
            VStack(spacing: 16) {
                Text("Parseltongue Required")
                    .font(.title2)

                Text("Only those who can speak to snakes may proceed.")
                    .padding(.horizontal, 4.0)

                Button {
                    isDrawerOpen.toggle()
                } label: {
                    Text("I Understand")
                }.buttonStyle(.neoBrutalism())
            }
        }
    }
}

struct FlatCardExampleView: View {
    var body: some View {
        VStack(spacing: 16.0) {
            NBFlatCard {
                Text("Quidditch Tryouts - This Saturday!")
            }

            NBFlatCard(type: .neutral) {
                Text("O.W.L. Exams Approaching - Study Hard!")
            }
        }
    }
}

struct AvatarExampleView: View {
    var body: some View {
        HStack(spacing: 20) {
            // Image Asset (System)
            NBAvatar(image: Image(systemName: "person.fill"), fallback: "NB")
            
            // URL
            NBAvatar(url: URL(string: "https://github.com/shadcn.png"), fallback: "CN")
            
            // Fallback
            NBAvatar(fallback: "JD")
        }
    }
}

struct ToastExampleView: View {
    @ObservedObject var toastManager: NBToastManager
    
    var body: some View {
        VStack(spacing: 12) {
            Button("Show Info Toast") {
                toastManager.show(title: "Did you know?", message: "Neo-brutalism is awesome!")
            }
            .buttonStyle(.neoBrutalism())
            
            Button("Show Success Toast") {
                toastManager.show(title: "Success", message: "Task completed successfully.", type: .success)
            }
            .buttonStyle(.neoBrutalism(type: .neutral))
            
            Button("Show Error Toast") {
                toastManager.show(title: "Error", message: "Something went wrong.", type: .error)
            }
            .buttonStyle(.neoBrutalism(variant: .reverse))
        }
    }
}

struct ContentView: View {
    @State var colorSceme: ColorScheme = .light
    @State var theme: NBTheme = .red
    @StateObject var toastManager = NBToastManager()
    
    let themes: [ThemeOption] = [
        ThemeOption(name: "Red", theme: .red),
        ThemeOption(name: "Orange", theme: .orange),
        ThemeOption(name: "Amber", theme: .amber),
        ThemeOption(name: "Yellow", theme: .yellow),
        ThemeOption(name: "Lime", theme: .lime),
        ThemeOption(name: "Green", theme: .green),
        ThemeOption(name: "Emerald", theme: .emerald),
        ThemeOption(name: "Teal", theme: .teal),
        ThemeOption(name: "Cyan", theme: .cyan),
        ThemeOption(name: "Sky", theme: .sky),
        ThemeOption(name: "Blue", theme: .blue),
        ThemeOption(name: "Indigo", theme: .indigo),
        ThemeOption(name: "Violet", theme: .violet),
        ThemeOption(name: "Purple", theme: .purple),
        ThemeOption(name: "Fuchsia", theme: .fuchsia),
        ThemeOption(name: "Pink", theme: .pink),
        ThemeOption(name: "Rose", theme: .rose)
    ]

    var body: some View {
        let exampleViews: [AnyView] = [
            AnyView(AccordionExampleView()),
            AnyView(AvatarExampleView()),
            AnyView(ToastExampleView(toastManager: toastManager)),
            AnyView(CheckboxExampleView()),
            AnyView(SwitchExampleView()),
            AnyView(AlertExampleView()),
            AnyView(BadgeExampleView()),
            AnyView(ButtonExampleView()),
            AnyView(CardExampleView()),
            AnyView(InputExampleView()),
            AnyView(ProgressExampleView()),
            AnyView(SliderExampleView()),
            AnyView(RadioGroupExampleView()),
            AnyView(RoundSkeletonExampleView()),
            AnyView(TextSkeletonExampleView()),
            AnyView(TabsExampleView()),
            AnyView(CollapsibleExampleView()),
            AnyView(DrawerExampleView()),
            AnyView(FlatCardExampleView()),
        ]

        ZStack {
            theme.background
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: theme.xlspacing) {
                    HStack {
                        Text("Neo Brutalism")
                            .font(.largeTitle)
                        Spacer()
                        Button {
                            withAnimation(.interactiveSpring) {
                                colorSceme = colorSceme == .light ? .dark : .light
                            }
                        } label: {
                            Image(systemName: colorSceme == .light ? "moon" : "sun.max")
                        }.buttonStyle(.neoBrutalism(type: .neutral))
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(themes) { option in
                                Button {
                                    withAnimation {
                                        theme = option.theme
                                    }
                                } label: {
                                    Circle()
                                        .fill(option.theme.main)
                                        .frame(width: 32, height: 32)
                                        .overlay(
                                            Circle()
                                                .strokeBorder(theme.text, lineWidth: 2)
                                                .opacity(theme.main == option.theme.main ? 1 : 0)
                                        )
                                        .nbBox(elevated: false)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 2)
                    }

                    ForEach(0 ..< exampleViews.count, id: \.self) { index in
                        NBCard(type: .neutral) {
                            exampleViews[index]
                        }
                    }
                }.padding(theme.padding)
            }
        }
        .nbToast(manager: toastManager)
        .nbTheme(theme)
        .colorScheme(colorSceme)
        .animation(.default, value: theme.main)
    }
}

#Preview {
    //BadgeExampleView()
    ContentView()
}

