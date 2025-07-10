//
//  ShowResultInfoView.swift
//  Interesting numbers
//
//  Created by Ivan Solohub on 10.07.2025.
//

import SwiftUI

struct ShowResultInfoView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var text: String = "This is a sample fact about number 100. It is a very interesting number because it is round, beautiful and impressive."

    var body: some View {
        ZStack {
            Color(hex: "#8033CC").ignoresSafeArea()
                
            VStack(spacing: 0) {
                
                HStack {
                    Spacer()
                    dismissButton
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)

                Text("100")
                    .font(.custom("OpenSans-Bold", size: 28))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)

                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 24)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .font(.custom("OpenSans-Medium", size: 16))
                    
                Spacer()
            }
        }
    }
    
    // MARK: - UI components sections
    private var dismissButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image("closeLogo")
                .renderingMode(.template)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ShowResultInfoView()
}
