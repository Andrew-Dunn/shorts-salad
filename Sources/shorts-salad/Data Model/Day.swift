//
// Struct that describes a date of a given competition day.
//

import Foundation

public struct Day {
    internal let id: UInt

    internal static let epochTimeZone = TimeZone(identifier: "Australia/Melbourne")!

    internal static let gregorianCalendar = {
        () -> Calendar in
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = Day.epochTimeZone
        return calendar
    }()

    internal static let dateFormatter = {
        () -> DateFormatter in
        var dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = Day.epochTimeZone
        dateFormatter.locale = Locale(identifier: "en_AU")
        return dateFormatter
    }()

    // First day of the competition was Tuesday, January 10, 2017
    private static let epoch = gregorianCalendar.date(from: DateComponents(
            calendar: gregorianCalendar, timeZone: epochTimeZone,
            era: 1, year: 2017, month: 1, day: 10))!

    public init(withID id: UInt) {
        self.id = id
    }

    public static func from(date: Date) -> Day? {
        let daysSinceEpoch = Day.gregorianCalendar.dateComponents(Set<Calendar.Component>([.day]),
                                                                  from: Day.epoch, to: date).day!
        if daysSinceEpoch < 0 {
            return nil
        }

        let a: UInt = (UInt(daysSinceEpoch) / 7) * 5
        let b: UInt = UInt(daysSinceEpoch) % 7

        switch (a, b) {
        case let (a, b) where (0...3).contains(b):
            return Day(withID: a + b)
        case let (a, 6):
            return Day(withID: a + 4)
        default:
            return nil
        }
    }

    public var date: Date {
        get {
            let a: Int = Int(id / 5) * 7
            let b: Int = Int(id) % 5
            let daysSinceEpoch: Int
            switch (a, b) {
            case let (a, 4):
                daysSinceEpoch = a + 6
            case let (a, b):
                daysSinceEpoch = a + b
            }
            return Day.gregorianCalendar.date(byAdding: .day, value: daysSinceEpoch, to: Day.epoch)!
        }
    }

    public var description: String {
        get {
            return Day.dateFormatter.string(from: self.date)
        }
    }
}
