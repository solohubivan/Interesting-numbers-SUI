//
//  MainView.swift
//  Interesting numbers
//
//  Created by Ivan Solohub on 08.07.2025.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var requestManager = UserRequestManager()
    
    @State private var selectedSearchMode: SearchMode = .userNumber
    @State private var inputText: String = ""
    @State private var rangeFrom: String = ""
    @State private var rangeTo: String = ""

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            contentView
        }
        .hideKeyboardOnTap()
        .fullScreenCover(isPresented: $requestManager.showResultView) {
            ShowResultInfoView(requestManager: requestManager)
        }
    }
    
    // MARK: - UI Components
    private var contentView: some View {
        VStack(spacing: 24) {
            titleSection
            Spacer()
            diceBackgroundImage
            Spacer()
            searchModeButtonsSection
            inputField
            submitButton
        }
        .padding(.top, 30)
        .padding(.bottom, 50)
    }

    private var titleSection: some View {
        VStack(spacing: 24) {
            Text(AppConstants.MainViewConstants.mainTitleLabelText)
                .font(.custom(AppConstants.Fonts.openSansBold, size: 28))
                .foregroundColor(Color(hex: "#2D2D2D"))
            
            Text(AppConstants.MainViewConstants.describeTitleLabelText)
                .font(.custom(AppConstants.Fonts.openSansLight, size: 16))
                .foregroundColor(Color(hex: "#2D2D2D"))
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
    }

    private var diceBackgroundImage: some View {
        Image(AppConstants.ImagesNames.mainViewBackgroundImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 97)
            .padding(.bottom, 20)
    }

    private var searchModeButtonsSection: some View {
        HStack(alignment: .center) {
            ForEach(SearchMode.allCases) { mode in
                createSearchModeButton(mode: mode)
                if mode != SearchMode.allCases.last {
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, -5)
    }

    private var inputField: some View {
        Group {
            switch selectedSearchMode {
            case .userNumber:
                singleInputField
            case .numberInRange:
                rangeInputFields
            case .multipleNumbers:
                multipleInputField
            case .randomNumber:
                EmptyView()
            }
        }
        .padding(.horizontal, 16)
    }
    
    private var singleInputField: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(AppConstants.MainViewConstants.enterHereLabelTxt)
                .font(.custom(AppConstants.Fonts.openSansRegular, size: 14))
                .foregroundColor(.black)
                .padding(.bottom, 4)
            styledTextField(text: $inputText)
        }
        .onChange(of: inputText) {
            guard selectedSearchMode == .userNumber else { return }
            inputText = inputText.sanitizedAsDigitsOnly()
        }
    }

    private var rangeInputFields: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(AppConstants.MainViewConstants.enterRangeLabelTxt)
                .font(.custom(AppConstants.Fonts.openSansRegular, size: 14))
                .foregroundColor(.black)
                .padding(.bottom, 4)
            HStack(spacing: 20) {
                styledTextField(placeholder: AppConstants.MainViewConstants.fromPlaceholderText, text: $rangeFrom)
                styledTextField(placeholder: AppConstants.MainViewConstants.toPlaceholderText, text: $rangeTo)
            }
            .onChange(of: rangeFrom) {
                guard selectedSearchMode == .numberInRange else { return }
                rangeFrom = rangeFrom.sanitizedAsDigitsOnly()
            }
            .onChange(of: rangeTo) {
                guard selectedSearchMode == .numberInRange else { return }
                rangeTo = rangeTo.sanitizedAsDigitsOnly()
            }
        }
    }

    private var multipleInputField: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(AppConstants.MainViewConstants.enterHereLabelTxt)
                .font(.custom(AppConstants.Fonts.openSansRegular, size: 14))
                .foregroundColor(.black)
                .padding(.bottom, 4)
            styledTextField(text: $inputText)
        }
        .onChange(of: inputText) {
            guard selectedSearchMode == .multipleNumbers else { return }
            inputText = inputText.sanitizedAsMultipleInput()
        }
    }

    private var submitButton: some View {
        Button(action: {
            switch selectedSearchMode {
            case .userNumber:
                requestManager.handleUserNumber(inputText)
            case .randomNumber:
                requestManager.handleRandomNumber()
            case .numberInRange:
                requestManager.handleRange(rangeFrom, rangeTo)
            case .multipleNumbers:
                requestManager.handleMultipleNumbers(inputText)
            }
        }) {
            Text(AppConstants.ButtonsTitles.displayFactBtnTxt)
                .font(.custom(AppConstants.Fonts.openSansSemibold, size: 18))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "#8033CC"))
                .cornerRadius(5)
                .frame(height: 52)
        }
        .padding(.horizontal, 16)
    }

    // MARK: - Private helpers methods
    private func createSearchModeButton(mode: SearchMode) -> some View {
        Button(action: {
            selectedSearchMode = mode
            inputText = ""
        }) {
            Text(mode.title)
                .font(.custom(AppConstants.Fonts.openSansSemibold, size: 13))
                .frame(width: 75, height: 75)
                .foregroundColor(selectedSearchMode == mode ? .white : Color(hex: "2D2D2D"))
                .background(selectedSearchMode == mode ? Color(hex: "#8033CC") : Color(hex: "#FAF7FD"))
                .border(selectedSearchMode == mode ? .clear : Color(hex: "#F5EFFB"), width: selectedSearchMode == mode ? 0 : 1)
                .cornerRadius(selectedSearchMode == mode ? 9 : 6)
                .shadow(color: Color.black.opacity(0.2), radius: 3, y: 2)
                .multilineTextAlignment(.center)
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
    }

    private func styledTextField(placeholder: String = "", text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding()
            .frame(height: 44)
            .background(Color(hex: "#FAF7FD"))
            .border(Color(hex: "#F5EFFB"), width: 1)
            .cornerRadius(5)
            .foregroundColor(Color(hex: "2D2D2D"))
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    MainView()
}
