import Foundation

/// Represents a competitor in the Shorts Salad.
public class Competitor {
    private let _name: String
    private let id: UUID
    private let admin: Bool

    public init(name: String, id: UUID = UUID())
    {
        self._name = name
        self.id = id
        self.admin = false
    }

    public var name: String {
        get {
            return _name
        }
    }
}
