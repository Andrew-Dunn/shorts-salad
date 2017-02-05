//
// Created by andrew on 29/01/17.
//

import Foundation
import Kitura
import LoggerAPI

private func pass(_ passed: Bool) -> String {
    if passed {
        return "PASS"
    }
    return "FAIL"
}

public let runTests: RouterHandler = {request, response, next in
    var output = "<h1>Tests</h1>"
    output.append("<table>")
    output.append("<tr><th colspan=\"2\"><h2>Public Holidays</h2></th></tr><tr><th>Test</th><th>Status</th></tr>")

    let jan2011_1 = Day.dateFormatter.date(from: "1/01/2011")!
    let jan2011_1Result = jan2011_1.isPublicHoliday()
    output.append("<tr><th>Saturday, 1/01/2011 is <b>NOT</b> a public holiday</th><td>\(pass(!jan2011_1Result))</td></tr>")
    let jan2011_2 = Day.dateFormatter.date(from: "2/01/2011")!
    let jan2011_2Result = jan2011_2.isPublicHoliday()
    output.append("<tr><th>Sunday, 2/01/2011 is <b>NOT</b> a public holiday</th><td>\(pass(!jan2011_2Result))</td></tr>")
    let jan2011_3 = Day.dateFormatter.date(from: "3/01/2011")!
    let jan2011_3Result = jan2011_3.isPublicHoliday()
    output.append("<tr><th>Monday, 3/01/2011 is a public holiday</th><td>\(pass(jan2011_3Result))</td></tr>")

    let sundayNewYears = Day.dateFormatter.date(from: "1/01/2017")!
    let sundayNewYearsResult = sundayNewYears.isPublicHoliday()
    output.append("<tr><th>Sunday, 1/01/2017 is <b>NOT</b> a public holiday</th><td>\(pass(!sundayNewYearsResult))</td></tr>")

    let mondayNewYearsPublicHoliday = Day.dateFormatter.date(from: "2/01/2017")!
    let mondayNewYearsPublicHolidayResult = mondayNewYearsPublicHoliday.isPublicHoliday()
    output.append("<tr><th>Monday, 2/01/2017 is a public holiday</th><td>\(pass(mondayNewYearsPublicHolidayResult))</td></tr>")

    let jan2018_1 = Day.dateFormatter.date(from: "1/01/2018")!
    let jan2018_1Result = jan2018_1.isPublicHoliday()
    output.append("<tr><th>Monday, 1/01/2018 is a public holiday</th><td>\(pass(jan2018_1Result))</td></tr>")

    let jan2017_26 = Day.dateFormatter.date(from: "26/01/2017")!
    let jan2017_26Result = jan2017_26.isPublicHoliday()
    output.append("<tr><th>Thursday, 26/01/2017 is a public holiday</th><td>\(pass(jan2017_26Result))</td></tr>")

    output.append("</table>")
    try response.send(output).end()
}