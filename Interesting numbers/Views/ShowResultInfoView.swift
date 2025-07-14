//
//  ShowResultInfoView.swift
//  Interesting numbers
//
//  Created by Ivan Solohub on 10.07.2025.
//

import SwiftUI

struct ShowResultInfoView: View {
    
    @ObservedObject var requestManager: UserRequestManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color(hex: "#8033CC").ignoresSafeArea()
            contentView
        }
    }

    // MARK: - UI Components
    private var contentView: some View {
        VStack(spacing: 0) {
            topDismissButton
            requestedNumberLabel
            numberInfoTextEditor
            Spacer()
        }
    }

    private var topDismissButton: some View {
        HStack {
            Spacer()
            Button(action: { dismiss() }) {
                Image(AppConstants.ImagesNames.dismissButtonIconImage)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 16)
    }

    private var requestedNumberLabel: some View {
        Text(requestManager.resultNumber)
            .font(.custom(AppConstants.Fonts.openSansBold, size: 28))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .padding(.top, 4)
    }

    private var numberInfoTextEditor: some View {
        TextEditor(text: .constant(requestManager.resultFact))
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .font(.custom(AppConstants.Fonts.openSansMedium, size: 16))
    }
}

#Preview {
    let mockManager = UserRequestManager()
    mockManager.resultNumber = "42"
    mockManager.resultFact = "42 is the answer to life, the universe, and everything."
    return ShowResultInfoView(requestManager: mockManager)
}
