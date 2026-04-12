import SwiftUI

enum PetProfileInfoItem {
    case weight(Double)
    case height(Int)
    case color(String)
    
    var title: String {
        switch self {
        case .weight: return "Вес"
        case .height: return "Рост"
        case .color: return "Цвет"
        }
    }
    
    var formattedVale: String {
        switch self {
        case .weight(let value): return "\(value.formatted(.number.locale(Locale(identifier: "ru_RU")))) кг"
        case .height(let value): return "\(value) см"
        case .color(let value): return value
        }
    }
}
