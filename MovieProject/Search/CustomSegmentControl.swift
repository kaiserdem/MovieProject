
import SwiftUI

struct CustomSegmentControl: View {
    @Binding var selectedType: MovieType
    let types: [MovieType] = [.movie, .series, .game]
    var onTypeChanged: () -> Void  // Додаємо callback
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(types, id: \.self) { type in
                Button(action: {
                    withAnimation(.easeInOut) {
                        selectedType = type
                        onTypeChanged()  // Викликаємо callback при зміні типу
                    }
                }) {
                    Text(type.rawValue.capitalized)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                if selectedType == type {
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 0.9, green: 0.3, blue: 0.5),
                                            Color(red: 0.4, green: 0.2, blue: 0.9)
                                            
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                    .cornerRadius(20)
                                }
                            }
                        )
                        .foregroundColor(selectedType == type ? .white : .gray)
                }
            }
        }
        .padding(4)
        .background(Color.black.opacity(0.3))
        .cornerRadius(24)
        .padding(.horizontal)
    }
}
