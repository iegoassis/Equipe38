//
//  TokenTypography.swift
//  Pomodoro
//
//  Created by iredefbmac_20 on 13/02/25.
//
import SwiftUI

struct TokenTypography {
    fileprivate enum FontSize: CGFloat {
        case extraExtraSmall = 11
        case extraSmall = 12
        case small = 14
        case mediumSmall = 16
        case medium = 18
        case large = 20
        case extraLarge = 32
    }
}

enum TypographyCase {
    /// Font: Satoshi-Medium; Size: 20
    case satoshiBody1Medium
    /// Font: Satoshi-Medium; Size: 14
    case satoshiBody3Medium
    /// Font: Satoshi-Medium; Size: 12
    case satoshiBody4Medium
    /// Font: Satoshi-Bold; Size: 12
    case satoshiheading5
    /// Font: Satoshi-Bold; Size: 18
    case satoshiHeading3
    /// Font: Satoshi-Regular; Size: 12
    case satoshiBody3Regular
    /// Font: SF Pro-Bold; Size: 14
    case satoshiHeading4
    /// Font: Satoshi-Medium; Size: 16
    case satoshiBody2Medium
    /// Font: Satoshi-Regular; Size: 16
    case satoshiBody2Regular
    /// Font: Satoshi-Regular; Size: 14
    case satoshiBody4Regular
    /// Font: Satoshi-Bold; Size: 24
    case satoshiHeading1
    /// Font: Satoshi-Light; Size: 12
    case satoshiSubtitle1Light
    /// Font: PPMonumentExpanded-Black; Size: 22
    case ppMonumentHeading1
}

extension Font {
    static func pomodoroUI(_ typographyCase: TypographyCase) -> Font {
        switch typographyCase {
        case .satoshiBody1Medium:
            return Font.custom("Satoshi-Medium", size: TokenTypography.FontSize.large.rawValue)
        case .satoshiBody3Medium:
            return Font.custom("Satoshi-Medium", size: TokenTypography.FontSize.small.rawValue)
        case .satoshiheading5:
            return Font.custom("Satoshi-Bold", size: TokenTypography.FontSize.extraSmall.rawValue)
        case .satoshiHeading3:
            return Font.custom("Satoshi-Bold", size: TokenTypography.FontSize.medium.rawValue)
        case .satoshiBody3Regular:
            return Font.custom("Satoshi-Regular", size: TokenTypography.FontSize.extraSmall.rawValue)
        case .satoshiHeading4:
            return Font.custom("Satoshi-Bold", size: TokenTypography.FontSize.small.rawValue)
        case .satoshiBody2Medium:
            return Font.custom("Satoshi-Medium", size: TokenTypography.FontSize.mediumSmall.rawValue)
        case .satoshiBody2Regular:
            return Font.custom("Satoshi-Regular", size: TokenTypography.FontSize.mediumSmall.rawValue)
        case .satoshiHeading1:
            return Font.custom("Satoshi-Black", size: TokenTypography.FontSize.extraLarge.rawValue)
        case .satoshiSubtitle1Light:
            return Font.custom("Satoshi-Light", size: TokenTypography.FontSize.extraSmall.rawValue)
        case .satoshiBody4Regular:
            return Font.custom("Satoshi-Regular", size: TokenTypography.FontSize.small.rawValue)
        case .satoshiBody4Medium:
            return Font.custom("Satoshi-Medium", size: TokenTypography.FontSize.extraSmall.rawValue)
        case .ppMonumentHeading1:
            return Font.custom("PPMonumentExtended-Black", size: TokenTypography.FontSize.extraLarge.rawValue)
        }
    }
}
