import Foundation

public enum Environment: String {
    case development
    case production

    public var name: String {
        return self.rawValue.uppercased()
    }
}
