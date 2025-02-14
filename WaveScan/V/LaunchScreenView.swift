import SwiftUI

struct LaunchScreenView: View {
    @Binding var isActive: Bool
    @State private var playAnimation = false 

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                Spacer()
                
                LottieView(
                    name: "scanning_animation",
                    loopMode: .playOnce,
                    isPlaying: playAnimation
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    playAnimation = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation {
                            isActive = false
                        }
                    }
                }

                Spacer()
            }
        }
    }
}
