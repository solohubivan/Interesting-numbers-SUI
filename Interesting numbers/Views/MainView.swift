//
//  MainView.swift
//  Interesting numbers
//
//  Created by Ivan Solohub on 08.07.2025.
//

import SwiftUI

struct MainView: View {
    
    @State private var inputText: String = ""
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            contentView
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
        HStack(alignment: .center, spacing: 8) {
            createSearchModeButton(label: "User Number", index: 0)
            createSearchModeButton(label: "Random Number", index: 1)
            createSearchModeButton(label: "Number in a range", index: 2)
            createSearchModeButton(label: "Multiple numbers", index: 3)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.bottom, -5)
    }
    
    private var inputField: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Enter here")
                .font(.custom("OpenSans-Regular", size: 14))
                .foregroundColor(.black)
                .padding(.bottom, 4)
            
            TextField("", text: $inputText)
                .padding()
                .frame(height: 44)
                .background(Color(hex: "#FAF7FD"))
                .border(Color(hex: "#F5EFFB"), width: 1)
                .cornerRadius(5)
                .foregroundColor(Color(hex: "2D2D2D"))
        }
        .padding(.horizontal, 16)
    }
    
    private var submitButton: some View {
        Button(action: {
            print("Submit tapped with input: \(inputText)")
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
    private func createSearchModeButton(label: String, index: Int) -> some View {
        Button(action: {
            selectedIndex = index
        }) {
            Text(label)
                .font(.custom("OpenSans-Semibold", size: 13))
                .frame(width: 75, height: 75)
                .foregroundColor(selectedIndex == index ? .white : Color(hex: "2D2D2D"))
                .background(selectedIndex == index ? Color(hex: "#8033CC") : Color(hex: "#FAF7FD"))
                .border(selectedIndex == index ? .clear : Color(hex: "#F5EFFB"), width: selectedIndex == index ? 0 : 1)
                .cornerRadius(selectedIndex == index ? 9 : 6)
                .shadow(color: Color.black.opacity(0.2), radius: 3, y: 2)
        }
    }
}

#Preview {
    MainView()
}
