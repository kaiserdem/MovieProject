import SwiftUI

struct TVShowDetailView: View {
    let show: TVThemoviedb
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Секція з постером
                ZStack(alignment: .topLeading) {
                    if let posterPath = show.posterPath {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                        }
                        .frame(height: 500)
                        .frame(maxWidth: .infinity)
                        .clipped()
                    }
                    
                    // Градієнт зверху для кращої видимості кнопки назад
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 100)
                    
                    // Кастомна кнопка назад
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                            Text("Назад")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(8)
                        .background(
                            Capsule()
                                .fill(Color.black.opacity(0.6))
                        )
                    }
                    .padding(.top, 50)
                    .padding(.leading, 16)
                }
                
                // Контентна частина
                VStack(alignment: .leading, spacing: 24) {
                    // Назва серіалу
                    Text(show.name ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 16)
                        .foregroundColor(.white)
                    
                    // Опис серіалу
                    Text(show.overview ?? "")
                        .font(.body)
                        .lineSpacing(4)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        .customBackground()
    }
}
