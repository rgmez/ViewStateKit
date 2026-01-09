import Foundation

internal func localized(_ key: String, tableName: String? = nil) -> String {
    NSLocalizedString(key, tableName: tableName, bundle: .module, value: "", comment: "")
}
