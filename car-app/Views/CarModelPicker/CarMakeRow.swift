import SwiftUI

struct CarMakeRow: View {
    let make: CarMake
    
    var body: some View {
        HStack(spacing: 15) {
            Image(make.logoName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: 50, height: 50)
                )
            
            Text(make.name)
                .font(.headline)
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
} 