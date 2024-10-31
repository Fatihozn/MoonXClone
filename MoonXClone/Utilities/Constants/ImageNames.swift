//
//  ImageNames.swift
//  MoonXClone
//
//  Created by Fatih Özen on 22.10.2024.
//

enum ImageNames: String {
    case fullMoon = "fullMoon"
    case crescentMoon = "crescentMoon"
    case homeHeaderMoon = "homeHeaderMoon"
    case homeHeaderBackgroundImage = "homeBackgroundImage"
    case fish = "fish"
    case getPremiumImage = "getPremiumImage"
    
    enum weatherImages: String, CaseIterable {
        case weather1 = "headerWeather1"
        case weather2 = "headerWeather2"
        case weather3 = "headerWeather3"
        case weather4 = "headerWeather4"
    }
    
    enum tabbarButtonImages: String {
        case settings = "gearshape.fill"
        case back = "chevron.left"
    }
    
    enum settingsItemImages: String {
        case privacy = "privacyIcon"
        case rate = "rateIcon"
        case restore = "restoreIcon"
        case terms = "termsIcon"
        case help = "helpIcon"
    }
    
    enum lunarItemImages: String {
        case business = "suitcase"
        case food = "foodIcon"
        case reletions = "relationsIcon"
    }
    
    enum paywallImages: String {
        case checkboxselected = "btn_checkbox2"
        case checkboxunselected = "btn_checkbox1"
    }
}
