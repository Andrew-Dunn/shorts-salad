//
// Created by andrew on 30/01/17.
//

import Foundation

private let publicHolidays: [PublicHoliday] = [
        NewYearsDay(),
        AustraliaDay()
]

public extension Date {
    func isPublicHoliday() -> Bool {
        for holiday in publicHolidays {
            if (holiday.falls(on: self)) {
                return true
            }
        }
        return false
    }
}