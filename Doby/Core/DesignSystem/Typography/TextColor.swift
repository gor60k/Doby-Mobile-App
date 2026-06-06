import SwiftUI

enum TextColor {
    /// Main readable content
    static let primary = Color.primary

    /// Supporting descriptions and secondary information
    static let secondary = Color.secondary

    /// Metadata, timestamps, counters, helper text
    static let tertiary = Color.secondary.opacity(0.7)

    /// Interactive/accented text
//    static let accent = Color.accentColor
    
    /// Success states
    static let success = Color.green

    /// Warning states
    static let warning = Color.orange

    /// Error and destructive actions
    static let destructive = Color.red

    /// Disabled content
    static let disabled = Color.secondary.opacity(0.4)
}
