//
//  ShowResultInfoView.swift
//  Interesting numbers
//
//  Created by Ivan Solohub on 10.07.2025.
//

import SwiftUI

struct ShowResultInfoView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var numberText: String
    @Binding var factText: String

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

                Text(numberText)
                    .font(.custom("OpenSans-Bold", size: 28))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)

                TextEditor(text: .constant(factText))
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

    private var dismissButton: some View {
        Button(action: { dismiss() }) {
            Image("closeLogo")
                .renderingMode(.template)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
        }
    }
}

//#Preview {
//    ShowResultInfoView()
//}
