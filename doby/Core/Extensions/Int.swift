extension Int {
    var yearsString: String {
        let remainder10 = self % 10
        let remainder100 = self % 100

        let suffix: String

        if remainder100 >= 11 && remainder100 <= 14 {
            suffix = "лет"
        } else if remainder10 == 1 {
            suffix = "год"
        } else if remainder10 >= 2 && remainder10 <= 4 {
            suffix = "года"
        } else {
            suffix = "лет"
        }

        return "\(self) \(suffix)"
    }
}
