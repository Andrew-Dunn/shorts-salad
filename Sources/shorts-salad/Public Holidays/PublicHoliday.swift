//
// Created by andrew on 29/01/17.
//

import Foundation
import LoggerAPI

public protocol PublicHoliday {
    static var name: String { get }
    static var canBeOnWeekend: Bool { get }
    static var normallyOn: (day: Int, month: Int) { get }
    static var precedingPublicHoliday: PublicHoliday? { get }
    static var followingPublicHoliday: PublicHoliday? { get }
    func falls(on date: Date) -> Bool

    var _name: String { get }
    var _canBeOnWeekend: Bool { get }
    var _normallyOn: (day: Int, month: Int) { get }
    var _precedingPublicHoliday: PublicHoliday? { get }
    var _followingPublicHoliday: PublicHoliday? { get }
}

public extension PublicHoliday {
    static var canBeOnWeekend: Bool {
        return false
    }
    static var precedingPublicHoliday: PublicHoliday? {
        return nil
    }
    static var followingPublicHoliday: PublicHoliday? {
        return nil
    }
    func falls(on date: Date) -> Bool {
        var originalComponents = Day.gregorianCalendar.dateComponents(in: Day.epochTimeZone, from: date)
        if Self.canBeOnWeekend {
            return (originalComponents.day == Self.normallyOn.day) &&
                    (originalComponents.month == Self.normallyOn.month)
        }
        var publicHolidayComponents = Day.gregorianCalendar.dateComponents(
                Set<Calendar.Component>([.day, .month, .year]), from: date)
        publicHolidayComponents.day = Self.normallyOn.day
        publicHolidayComponents.month = Self.normallyOn.month
        let actualPublicHoliday = Day.gregorianCalendar.date(from: publicHolidayComponents)!
        // S S M T W T F
        let weekDay = Day.gregorianCalendar.component(.weekday, from: actualPublicHoliday) % 7

        switch (weekDay, Self.precedingPublicHoliday, Self.followingPublicHoliday) {
        case (0, _, _):
            // On a Saturday, the public holiday is always moved to Monday.
            let monday = Day.gregorianCalendar.date(byAdding: .day, value: 2, to: actualPublicHoliday)!
            let mondayComponents = Day.gregorianCalendar.dateComponents(Set<Calendar.Component>([.day, .month, .year]),
                                                                        from: monday)
            return (mondayComponents.day == originalComponents.day) &&
                    (mondayComponents.month == originalComponents.month) &&
                    (mondayComponents.year == originalComponents.year)
        case (1, nil, nil):
            // Sunday with no preceding or following public holiday, is always moved to Monday.
            let monday = Day.gregorianCalendar.date(byAdding: .day, value: 1, to: actualPublicHoliday)!
            let mondayComponents = Day.gregorianCalendar.dateComponents(Set<Calendar.Component>([.day, .month, .year]),
                                                                        from: monday)
            return (mondayComponents.day == originalComponents.day) &&
                    (mondayComponents.month == originalComponents.month) &&
                    (mondayComponents.year == originalComponents.year)
        case let (1, nil, following) where following != nil:
            // Sunday with a following public holiday
            let tuesday = Day.gregorianCalendar.date(byAdding: .day, value: 3, to: actualPublicHoliday)!
            let tuesdayComponents = Day.gregorianCalendar.dateComponents(Set<Calendar.Component>([.day, .month, .year]),
                                                                         from: tuesday)
            return (tuesdayComponents.day == originalComponents.day) &&
                    (tuesdayComponents.month == originalComponents.month) &&
                    (tuesdayComponents.year == originalComponents.year)
        case let (1, preceding, _) where preceding != nil:
            // Sunday with a preceding public holiday
            let targetDay = (preceding!._canBeOnWeekend ? 2 : 3)
            let target = Day.gregorianCalendar.date(byAdding: .day, value: targetDay - 1, to: actualPublicHoliday)!
            let targetComponents = Day.gregorianCalendar.dateComponents(Set<Calendar.Component>([.day, .month, .year]),
                                                                        from: target)
            return (targetComponents.day == originalComponents.day) &&
                    (targetComponents.month == originalComponents.month) &&
                    (targetComponents.year == originalComponents.year)
        default:
            // Any other day, the public holiday is just on its normal day.
            return (originalComponents.day! == Self.normallyOn.day) &&
                    (originalComponents.month! == Self.normallyOn.month)
        }
    }

    var _name: String {
        return Self.name
    }
    var _canBeOnWeekend: Bool {
        return Self.canBeOnWeekend
    }
    var _normallyOn: (day: Int, month: Int) {
        return (day: Self.normallyOn.day, month: Self.normallyOn.month)
    }
    var _precedingPublicHoliday: PublicHoliday? {
        return Self.precedingPublicHoliday
    }
    var _followingPublicHoliday: PublicHoliday? {
        return Self.followingPublicHoliday
    }
}

