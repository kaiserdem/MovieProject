
import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Пошук...", text: $text)
                    .foregroundColor(.white)
                    .accentColor(.white)
                    .onSubmit {
                        onSearch()
                    }
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(10)
            .background(Color.black.opacity(0.3))
            .cornerRadius(20)
        }
        .padding(.horizontal)
    }
}
