import SwiftUI

enum PetProfileInfoItem {
    case weight(Int)
    case height(Int)
    
    var title: String {
        switch self {
        case .weight: return "Вес"
        case .height: return "Рост"
        }
    }
    
    var formattedVale: String {
        switch self {
        case .weight(let value): return "\(value.formatted(.number.locale(Locale(identifier: "ru_RU")))) кг"
        case .height(let value): return "\(value) см"
        }
    }
}
