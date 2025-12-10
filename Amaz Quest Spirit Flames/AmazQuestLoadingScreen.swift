import SwiftUI

// MARK: - Протоколы для улучшения расширяемости

protocol ProgressDisplayable {
    var progressPercentage: Int { get }
}

protocol BackgroundProviding {
    associatedtype BackgroundContent: View
    func makeBackground() -> BackgroundContent
}

// MARK: - Новый стиль загрузочного экрана

struct AmazQuestLoadingOverlay: View, ProgressDisplayable {
    let progress: Double
    var progressPercentage: Int { Int(progress * 100) }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Новый фон: вертикальный градиент с темно-фиолетовым и синим
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.13, green: 0.09, blue: 0.23),
                        Color(red: 0.18, green: 0.13, blue: 0.36),
                        Color(red: 0.22, green: 0.18, blue: 0.45)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 36) {
                    // Новый прогресс-бар
                    VStack(spacing: 16) {
                        Text("AmazQuest Loading")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.85, green: 0.92, blue: 1.0))
                            .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 2)

                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.18, green: 0.13, blue: 0.36).opacity(0.35))
                                .frame(height: 22)
                                .shadow(color: Color.black.opacity(0.18), radius: 2, x: 0, y: 1)

                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 0.44, green: 0.78, blue: 0.98),
                                            Color(red: 0.52, green: 0.36, blue: 0.98),
                                            Color(red: 0.98, green: 0.36, blue: 0.82)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(width: max(24, CGFloat(progress) * geo.size.width * 0.7), height: 22)
                                .animation(.easeOut(duration: 0.4), value: progress)
                        }
                        .padding(.horizontal, 32)

                        Text("\(progressPercentage)%")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(Color(red: 0.98, green: 0.92, blue: 1.0).opacity(0.85))
                            .padding(.top, 2)
                    }
                    .padding(.vertical, 32)
                    .padding(.horizontal, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.08))
                            .shadow(color: Color.black.opacity(0.18), radius: 8, x: 0, y: 4)
                    )

                    // Новый декоративный элемент: светящийся шар
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.52, green: 0.36, blue: 0.98).opacity(0.45),
                                    Color.clear
                                ]),
                                center: .center,
                                startRadius: 0,
                                endRadius: 120
                            )
                        )
                        .frame(width: 180, height: 180)
                        .blur(radius: 2)
                        .offset(y: 40)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

// MARK: - Новый фон

struct AmazQuestBackground: View, BackgroundProviding {
    func makeBackground() -> some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.13, green: 0.09, blue: 0.23),
                Color(red: 0.18, green: 0.13, blue: 0.36),
                Color(red: 0.22, green: 0.18, blue: 0.45)
            ]),
            startPoint: .top,
            endPoint: .bottom
        ).ignoresSafeArea()
    }

    var body: some View {
        makeBackground()
    }
}

// MARK: - Previews

#if canImport(SwiftUI)
import SwiftUI
#endif

@available(iOS 17.0, *)
#Preview("Vertical") {
    AmazQuestLoadingOverlay(progress: 0.2)
}

@available(iOS 17.0, *)
#Preview("Horizontal", traits: .landscapeRight) {
    AmazQuestLoadingOverlay(progress: 0.2)
}

struct AmazQuestLoadingOverlay_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AmazQuestLoadingOverlay(progress: 0.2)
                .previewDisplayName("Vertical (Legacy)")

            AmazQuestLoadingOverlay(progress: 0.2)
                .previewDisplayName("Horizontal (Legacy)")
                .previewLayout(.fixed(width: 812, height: 375))
        }
    }
}
