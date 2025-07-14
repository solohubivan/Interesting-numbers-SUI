//
//  MainView.swift
//  Interesting numbers
//
//  Created by Ivan Solohub on 08.07.2025.
//

import SwiftUI
import NumbersCore

struct MainView: View {
    
    @State private var selectedSearchMode: SearchMode = .userNumber
    @State private var inputText: String = ""
    @State private var rangeFrom: String = ""
    @State private var rangeTo: String = ""
    
    @State private var showResultView = false
    @State private var resultNumber: String = ""
    @State private var resultFact: String = ""
    
    private let apiBuilder = APIBuilder()
    private let apiManager = NumbersApiDataManager()
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            contentView
        }
        .hideKeyboardOnTap()
        .fullScreenCover(isPresented: $showResultView) {
            ShowResultInfoView(numberText: $resultNumber, factText: $resultFact)
        }
    }
    
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
    
    // MARK: - UI components sections
    private var titleSection: some View {
        VStack(spacing: 24) {
            Text("Interesting Numbers")
                .font(.custom("OpenSans-Bold", size: 28))
                .foregroundColor(Color(hex: "#2D2D2D"))
            
            Text("This App about facts of Numbers\nand Dates")
                .font(.custom("OpenSans-Light", size: 16))
                .foregroundColor(Color(hex: "#2D2D2D"))
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
    }
    
    private var diceBackgroundImage: some View {
        Image("bgImage")
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
            Text("Enter here")
                .font(.custom("OpenSans-Regular", size: 14))
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
            Text("Enter range")
                .font(.custom("OpenSans-Regular", size: 14))
                .foregroundColor(.black)
                .padding(.bottom, 4)
            
            HStack(spacing: 20) {
                styledTextField(placeholder: "From", text: $rangeFrom)
                styledTextField(placeholder: "To", text: $rangeTo)
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
            Text("Enter here")
                .font(.custom("OpenSans-Regular", size: 14))
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
            handleRequest()
        }) {
            Text("Display Fact")
                .font(.custom("OpenSans-Semibold", size: 18))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "#8033CC"))
                .cornerRadius(5)
                .frame(height: 52)
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: - Private helper methods
    private func createSearchModeButton(mode: SearchMode) -> some View {
        Button(action: {
            selectedSearchMode = mode
            inputText = ""
        }) {
            Text(mode.title)
                .font(.custom("OpenSans-Semibold", size: 13))
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
    
    // MARK: - Actions helper methods
    
    private func handleRequest() {
        switch selectedSearchMode {
        case .userNumber:
            handleUserNumberRequest()
        case .randomNumber:
            handleRandomNumberRequest()
        case .numberInRange:
            handleNumberInRangeRequest()
        case .multipleNumbers:
            handleMultipleNumbersRequest()
        }
    }
    
    private func processRequest(requestedNumber: String, displayNumber: String? = nil, type: NumberFactType) {
        let urlString = apiBuilder.createLinkForRequest(type: type)
        
        apiManager.fetchFact(for: urlString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fact):
                    self.resultNumber = displayNumber ?? requestedNumber
                    self.resultFact = fact.trimmingCharacters(in: CharacterSet(charactersIn: "{}"))
                    self.showResultView = true
                case .failure:
                    break
                }
            }
        }
    }
    
    private func handleUserNumberRequest() {
        let cleaned = inputText.trimmingCharacters(in: .whitespaces)
        guard !cleaned.isEmpty else { return }
        
        let cleanedNumber = apiBuilder.orderingRequestString(from: cleaned)
        processRequest(requestedNumber: cleanedNumber, type: .trivia(requestedNumber: cleanedNumber))
    }
    
    private func handleRandomNumberRequest() {
        let randomNumber = Int.random(in: 0...999)
        processRequest(requestedNumber: String(randomNumber), type: .trivia(requestedNumber: String(randomNumber)))
    }
    
    private func handleNumberInRangeRequest() {
        let fromText = rangeFrom.trimmingCharacters(in: .whitespaces)
        let toText = rangeTo.trimmingCharacters(in: .whitespaces)

        guard !fromText.isEmpty, !toText.isEmpty,
              let from = Int(fromText), let to = Int(toText) else { return }

        let minVal = min(from, to)
        let maxVal = max(from, to)
        
        processRequest(requestedNumber: "\(minVal) - \(maxVal)", type: .range(min: "\(minVal)", max: "\(maxVal)"))
    }
    
    private func handleMultipleNumbersRequest() {
        let cleanedInput = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanedInput.isEmpty else { return }

        let components = cleanedInput
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty && $0.allSatisfy(\.isNumber) }

        guard !components.isEmpty else { return }

        let requestString = components.joined(separator: ",")
        let displayString = components.joined(separator: ", ")

        processRequest(requestedNumber: requestString, displayNumber: displayString, type: .trivia(requestedNumber: requestString))
    }
}

#Preview {
    MainView()
}
