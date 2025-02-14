import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    // MARK: - Properties
    let name: String
    let loopMode: LottieLoopMode
    var isPlaying: Bool

    // MARK: - Coordinator
    class Coordinator {
        var parent: LottieView
        var animationView: LottieAnimationView

        init(parent: LottieView, animationView: LottieAnimationView) {
            self.parent = parent
            self.animationView = animationView
        }

        func updateAnimationState(isPlaying: Bool) {
            if isPlaying {
                if !animationView.isAnimationPlaying {
                    animationView.play()
                }
            } else {
                animationView.pause()
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        let animationView = LottieAnimationView()
        return Coordinator(parent: self, animationView: animationView)
    }

    // MARK: - UIViewRepresentable Methods
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = context.coordinator.animationView

        setupAnimationView(animationView, in: view)

        if isPlaying {
            animationView.play()
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.updateAnimationState(isPlaying: isPlaying)
    }

    // MARK: - Private Methods
    private func setupAnimationView(_ animationView: LottieAnimationView, in view: UIView) {
        animationView.animation = LottieAnimation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode

        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}
