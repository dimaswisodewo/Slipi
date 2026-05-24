import SwiftUI

struct BottomSheet: View {
    @State private var rainSliderValue: Double = 50.0
    @State private var windSliderValue: Double = 50.0
    @State private var thunderSliderValue: Double = 50.0
    @State private var showAudioTuning = false
    @State private var sheetDetail: InventoryItem? = InventoryItem(
        id: "0123456789",
        partNumber: "Z-1234A",
        quantity: 100,
        name: "Widget"
    )

    var body: some View {
        Button("Show Part Details") {
            sheetDetail = InventoryItem(
                id: "0123456789",
                partNumber: "Z-1234A",
                quantity: 100,
                name: "Widget"
            )
        }
        .sheet(item: $sheetDetail, onDismiss: didDismiss) { detail in
            VStack(spacing: 12) {
                
              
                Text("Audio Mixer")
                    .font(.system(size: 23, weight: .semibold))
                    .padding(.top, 40)
               
                VStack(spacing: 20) {
                    AudioSliderComponent(
                        title: "Rain",
                        systemImageName: "cloud.rain.fill",
                        sliderValue: $rainSliderValue
                        
                    )  {
                        showAudioTuning = true
                    }
                    
                    AudioSliderComponent(
                        title: "Wind",
                        systemImageName: "wind",
                        sliderValue: $windSliderValue
                        
                    ) {
                        showAudioTuning = true
                    }
                    AudioSliderComponent(
                        title: "Thunder",
                        systemImageName: "cloud.bolt.rain.fill",
                        sliderValue: $thunderSliderValue
                        
                    ) {
                        showAudioTuning = true
                    }

                    }
                .padding(.top, 16)

                Spacer()

                PlayPauseComponent()
                    .padding(.bottom, 32)
            }
            .padding(.horizontal, 16)
            .foregroundColor(.white)
            .blur(radius: showAudioTuning ? 6 : 0)
            .animation(.easeInOut(duration: 0.2), value: showAudioTuning)
            .presentationDetents([.medium, .large])
            .presentationBackground(.black)
            .sheet(isPresented: $showAudioTuning) {
                AudioTuning()
                    .presentationDetents([.medium, .large])
                    .presentationBackground(.black)
            }
        }
    }

    func didDismiss() {
    }
}

struct InventoryItem: Identifiable {
    var id: String
    let partNumber: String
    let quantity: Int
    let name: String
}


#Preview {
    BottomSheet()
}
