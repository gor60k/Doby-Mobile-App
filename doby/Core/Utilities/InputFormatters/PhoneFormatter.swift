import PhoneNumberKit

final class PhoneFormatter {
    
    private let phoneNumberUtility = PhoneNumberUtility()
    private let defaultRegion: String
    
    private lazy var partialFormatter: PartialFormatter = {
        return PartialFormatter(
            defaultRegion: defaultRegion,
            withPrefix: true,
            maxDigits: 15
        )
    }()
    
    init(defaultRegion: String) {
        self.defaultRegion = defaultRegion
    }
    
    func formatPartial(_ text: String) -> String {
        return partialFormatter.formatPartial(text)
    }
    
    func format(_ text: String, toType type: PhoneNumberFormat = .international) -> String? {
        do {
            let number = try phoneNumberUtility.parse(text, withRegion: defaultRegion, ignoreType: true)
            return phoneNumberUtility.format(number, toType: type)
        } catch {
            return nil
        }
    }
    
    func normalized(_ text: String) -> String? {
        do {
            let number = try phoneNumberUtility.parse(text, withRegion: defaultRegion, ignoreType: true)
            return phoneNumberUtility.format(number, toType: .e164)
        } catch {
            return nil
        }
    }
}
