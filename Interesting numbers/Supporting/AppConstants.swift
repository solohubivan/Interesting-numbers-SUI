//
//  AppConstants.swift
//  Interesting numbers
//
//  Created by Ivan Solohub on 14.07.2025.
//

import Foundation

enum AppConstants {
    
    enum Fonts {
        static let openSansBold: String = "OpenSans-Bold"
        static let openSansLight: String = "OpenSans-Light"
        static let openSansRegular: String = "OpenSans-Regular"
        static let openSansSemibold: String = "OpenSans-Semibold"
        static let openSansMedium: String = "OpenSans-Medium"
    }
    
    enum ImagesNames {
        static let mainViewBackgroundImage: String = "bgImage"
        static let dismissButtonIconImage: String = "closeLogo"
    }
    
    enum ButtonsTitles {
        static let displayFactBtnTxt: String = "Display Fact"
    }
    
    enum SearchModeButtonsTitles {
        static let userNumber: String = "User Number"
        static let randomNumber: String = "Random Number"
        static let numberInRange: String = "Number in a range"
        static let multipleNumbers: String = "Multiple numbers"
    }
    
    enum MainViewConstants {
        static let mainTitleLabelText: String = "Interesting Numbers"
        static let describeTitleLabelText: String = "This App about facts of Numbers\nand Dates"
        static let enterHereLabelTxt: String = "Enter here"
        static let enterRangeLabelTxt: String = "Enter range"
        static let fromPlaceholderText: String = "From"
        static let toPlaceholderText: String = "To"
    }
}
