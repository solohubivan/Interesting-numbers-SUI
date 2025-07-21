//
//  MainView.swift
//  Interesting numbers
//
//  Created by Ivan Solohub on 08.07.2025.
//

import SwiftUI

struct MainView: View {
    
    @State private var requestManager = UserRequestManager()
    @State private var viewModel = MainViewModel()
    
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
            Text(viewModel.mainTitleText)
                .font(.custom(AppConstants.Fonts.openSansBold, size: 28))
                .foregroundColor(Color("NightRider"))
            
            Text(viewModel.descriptionText)
                .font(.custom(AppConstants.Fonts.openSansLight, size: 16))
                .foregroundColor(Color("NightRider"))
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
            switch viewModel.selectedSearchMode {
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
            Text(viewModel.enterHereLabelText)
                .font(.custom(AppConstants.Fonts.openSansRegular, size: 14))
                .foregroundColor(.black)
                .padding(.bottom, 4)
            styledTextField(text: $inputText)
        }
        .onChange(of: inputText) {
            guard viewModel.selectedSearchMode == .userNumber else { return }
            inputText = inputText.sanitizedAsDigitsOnly()
        }
    }

    private var rangeInputFields: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(viewModel.enterRangeLabelText)
                .font(.custom(AppConstants.Fonts.openSansRegular, size: 14))
                .foregroundColor(.black)
                .padding(.bottom, 4)
            HStack(spacing: 20) {
                styledTextField(placeholder: viewModel.fromPlaceholderText, text: $rangeFrom)
                styledTextField(placeholder: viewModel.toPlaceholderText, text: $rangeTo)
            }
            .onChange(of: rangeFrom) {
                guard viewModel.selectedSearchMode == .numberInRange else { return }
                rangeFrom = rangeFrom.sanitizedAsDigitsOnly()
            }
            .onChange(of: rangeTo) {
                guard viewModel.selectedSearchMode == .numberInRange else { return }
                rangeTo = rangeTo.sanitizedAsDigitsOnly()
            }
        }
    }

    private var multipleInputField: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(viewModel.enterHereLabelText)
                .font(.custom(AppConstants.Fonts.openSansRegular, size: 14))
                .foregroundColor(.black)
                .padding(.bottom, 4)
            styledTextField(text: $inputText)
        }
        .onChange(of: inputText) {
            guard viewModel.selectedSearchMode == .multipleNumbers else { return }
            inputText = inputText.sanitizedAsMultipleInput()
        }
    }

    private var submitButton: some View {
        Button(action: {
            viewModel.submitRequest(
                inputText: inputText,
                rangeFrom: rangeFrom,
                rangeTo: rangeTo,
                requestManager: requestManager
            )
        }) {
            Text(viewModel.displayFactButtonText)
                .font(.custom(AppConstants.Fonts.openSansSemibold, size: 18))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("PrimaryPurple"))
                .cornerRadius(5)
                .frame(height: 52)
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: - Private helpers methods
    private func createSearchModeButton(mode: SearchMode) -> some View {
        Button(action: {
            viewModel.selectedSearchMode = mode
            inputText = ""
        }) {
            Text(mode.title)
                .font(.custom(AppConstants.Fonts.openSansSemibold, size: 13))
                .frame(width: 75, height: 75)
                .foregroundColor(viewModel.selectedSearchMode == mode ? .white : Color("NightRider"))
                .background(viewModel.selectedSearchMode == mode ? Color("PrimaryPurple") : Color("ObjectsBackgroundColor"))
                .border(viewModel.selectedSearchMode == mode ? .clear : Color("ObjectsBorderColor"), width: viewModel.selectedSearchMode == mode ? 0 : 1)
                .cornerRadius(viewModel.selectedSearchMode == mode ? 9 : 6)
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
            .background(Color("ObjectsBackgroundColor"))
            .border(Color("ObjectsBorderColor"), width: 1)
            .cornerRadius(5)
            .foregroundColor(Color("NightRider"))
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    MainView()
}
