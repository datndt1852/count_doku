//
//  StyleKit.swift
//  count_doku
//
//  Created by Tien Dat on 5/12/24.
//

import UIKit

struct StyleKit {
    @nonobjc static var MainColorNavigationBar: UIColor {
        return UIColor.clear
    }
    
    static var buttonMarginOffset: CGFloat { return -5 }
    static var fontName: String { return "Poppins-Regular" }
    static var fontNameBold: String { return "Poppins-Bold" }
    static var fontNameExtraBold: String { return "Poppins-ExtraBold" }
    
    static func appFont(with font: AppFont) -> UIFont {
        let size = font.size.rawValue
        
        if let font = AppFontStyle.font(for: font.fontName, with: font.size, and: font.style) {
            return font
        } else {
            return UIFont(descriptor: UIFontDescriptor(name: font.fontName,
                                                       size: size),
                          size: size)
        }
    }
    
    static func appFont(with fontSize: AppFontSize,
                        and style: AppFontStyle = .regular) -> UIFont {
        let font = AppFont(size: fontSize, style: style)
        return appFont(with: font)
    }
    
    static func appFont(with size: CGFloat, and font: String) -> UIFont {
        let font = UIFont(name: font, size: size) ?? UIFont.systemFont(ofSize: size)
        return font
    }
    
    static func underlineAttributedString(with text: String, for fontSize: AppFontSize) -> NSAttributedString? {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: appFont(with: fontSize, and: .black),
            .foregroundColor: UIColor.black,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attrString = NSAttributedString(string: text,
                                            attributes: attrs)
        return attrString
    }
    
    static func highlightKeyWord(_ keyword: String, _ text: String,
                                 with fontSize: AppFontSize,
                                 and style: AppFontStyle = .regular,
                                 color: UIColor = .black) -> NSMutableAttributedString? {
        var attrText: NSMutableAttributedString?
        let textLowercase = text.lowercased()
        let range = (textLowercase as NSString).range(of: keyword.lowercased())
        if range.location != NSNotFound {
            let highlightAttr: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: StyleKit.appFont(with: fontSize, and: style),
                NSAttributedString.Key.foregroundColor: color
            ]
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttributes(highlightAttr, range: range)
            attrText = attributedText
        }
        
        return attrText
    }
    
    static func highlightKeyWords(_ keywords: [String], _ text: String,
                                 with fontSize: AppFontSize,
                                 and style: AppFontStyle = .regular,
                                 isUnderline: Bool = false,
                                 color: UIColor = .black) -> NSMutableAttributedString? {
        var attrText: NSMutableAttributedString?
        let textLowercase = text.lowercased()
        var ranges = [NSRange]()
        keywords.forEach { keyword in
            let range = (textLowercase as NSString).range(of: keyword.lowercased())
            if range.location != NSNotFound {
                ranges.append(range)
            }
        }
        
        if ranges.count > 0 {
            var highlightAttr: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: StyleKit.appFont(with: fontSize, and: style),
                NSAttributedString.Key.foregroundColor: color
            ]
            if isUnderline {
                highlightAttr[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue
            }
            let attributedText = NSMutableAttributedString(string: text)
            ranges.forEach { range in
                attributedText.addAttributes(highlightAttr, range: range)
            }
            attrText = attributedText
        }
        
        return attrText
    }

    static func concatAttributesString(string1: String, font1: UIFont, string2: String, font2: UIFont, color: UIColor) -> NSAttributedString {
        let baseAttributes: [NSAttributedString.Key: Any] = [
            .font: font1,
            .foregroundColor: color
        ]
        let baseAttributes2: [NSAttributedString.Key: Any] = [
            .font: font2,
            .foregroundColor: color
        ]
        
        let attrString = NSMutableAttributedString(string: string1)
        attrString.addAttributes(baseAttributes, range: NSRange(location: 0, length: attrString.length))
        
        let attrString2 = NSMutableAttributedString(string: string2)
        attrString2.addAttributes(baseAttributes2, range: NSRange(location: 0, length: attrString2.length))
        
        attrString.append(attrString2)
        
        return attrString
    }
  
    
}

extension AppFont {
    static let lato: String = "Poppins"
}

struct AppFont {
    let fontName: String
    let size: AppFontSize
    let style: AppFontStyle
    
    init(size: AppFontSize, style: AppFontStyle) {
        self.fontName = AppFont.lato
        self.size = size
        self.style = style
    }
    
    init(font: String, size: AppFontSize, style: AppFontStyle) {
        self.fontName = font
        self.size = size
        self.style = style
    }
    
    func toUIFont() -> UIFont? {
        return AppFontStyle.font(for: fontName, with: size, and: style)
            ?? UIFont(name: fontName, size: size.rawValue)
    }
}

extension UIFont {
    static var appMediumRegular: UIFont {
        StyleKit.appFont(with: .xMedium, and: .regular)
    }
    
    static var appMSmallRegular: UIFont {
        StyleKit.appFont(with: .mSmall, and: .regular)
    }
    
    static var appMediumBold: UIFont {
        StyleKit.appFont(with: .medium, and: .bold)
    }
    
    static var appMSmallBold: UIFont {
        StyleKit.appFont(with: .mSmall, and: .bold)
    }
}

extension CGFloat {
    @nonobjc static var appCorner: CGFloat { return 10 }
}

extension UIColor {
    @nonobjc class var appTint: UIColor { return UIColor.red }
    @nonobjc class var appBar: UIColor { return .white }
    @nonobjc class var appTitleBar: UIColor { return .black }
    @nonobjc class var popoverBackground: UIColor { return UIColor(red: 0.8863, green: 0.8863, blue: 0.8863, alpha: 1.0) }
    @nonobjc class var darkRed: UIColor { return UIColor(red: 137.0/255.0, green: 0, blue: 0, alpha: 1.0) }
    
    convenience init?(hexString: String) {
            var hexFormatted = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
            hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")

            var rgb: UInt64 = 0
            Scanner(string: hexFormatted).scanHexInt64(&rgb)

            let length = hexFormatted.count

            switch length {
            case 6: // RGB (no alpha)
                let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
                let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
                let blue = CGFloat(rgb & 0x0000FF) / 255.0
                self.init(red: red, green: green, blue: blue, alpha: 1.0)
            case 8: // RGBA
                let red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
                let green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
                let blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
                let alpha = CGFloat(rgb & 0x000000FF) / 255.0
                self.init(red: red, green: green, blue: blue, alpha: alpha)
            default:
                return nil
            }
        }
}

extension UIColor {
    //new
    static var hexEBFF9B: UIColor {
        return UIColor(hexString: "#EBFF9B") ?? .white
    }
    static var hex8ED1D1: UIColor {
        return UIColor(hexString: "#8ED1D1") ?? .white
    }
    static var hexBB79D2: UIColor {
        return UIColor(hexString: "#BB79D2") ?? .white
    }
    
}

extension UIImage {
    @nonobjc class var placeHolder: UIImage {
        return UIImage(named: "placeholder") ?? UIImage()
    }
}

struct AppSpacing {
    static let small: CGFloat = 6
    static let xSmall: CGFloat = 8
    static let medium: CGFloat = 18
    static let xMedium: CGFloat = 26
    static let large: CGFloat = 30
    static let xLarge: CGFloat = 40
}

enum AppFontSize: CGFloat {
    case little = 7
    case xMicro = 8
    case micro = 9
    case xxSmall = 10
    case xSmall = 11
    case small = 12
    case mSmall = 13
    case medium = 14
    case mMedium = 15
    case xMedium = 16
    case lxMedium = 18
    case xxMedium = 20
    case large28 = 28
    case large = 30
    case large32 = 32
    case xLarge = 40
    case xxLarge = 72
}

enum AppFontStyle: String {
    case extraLight = "ExtraLight"
    case thinItalic = "ThinItalic"
    case extraThinItalic = "ExtraThinItalic"
    case boldItalic = "BoldItalic"
    case light = "Light"
    case medium = "Medium"
    case semiBoldItalic = "SemiBoldItalic"
    case extraSemiBold = "ExtraBoldItalic"
    case extraBold = "ExtraBold"
    case blackItalic = "BlackItalic"
    case regular = "Regular"
    case lightItalic = "LightItalic"
    case bold = "Bold"
    case black = "Black"
    case thin = "Thin"
    case semiBold = "SemiBold"
    case italic = "Italic"
    case mediumItalic = "MediumItalic"
    
    static func font(for name: String, with size: AppFontSize, and style: AppFontStyle) -> UIFont? {
        let familyFont = UIFont.fontNames(forFamilyName: name)
        let fonts = familyFont.filter({ $0.contains(style.rawValue) })
        guard fonts.count > 0 else { return nil }
        
        if fonts.count == 1,
            let fontName = fonts.first,
            let font = UIFont(name: fontName, size: size.rawValue) {
            return font
        } else {
            let fontName = "\(name.replacingOccurrences(of: " ", with: ""))-\(style.rawValue)"
            let font = UIFont(name: fontName, size: size.rawValue)
            return font
        }
    }
}

