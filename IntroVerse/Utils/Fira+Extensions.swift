import UIKit
extension UIFont {
    static func fira(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "fira"
        var weightString: String
        switch weight {
        case .bold:
            weightString = "Bold"
        case .light:
            weightString = "Light"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        case .semibold:
            weightString = "Semibold"
        default:
            weightString = "Regular"
        }
        
        return UIFont(name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: weight)
    }
}
