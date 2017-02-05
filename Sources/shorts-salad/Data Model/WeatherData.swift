//
// Created by andrew on 29/01/17.
//

import Foundation

public struct WeatherData {
    private let day: Day;
    private let maxTemp: Float;
    private let chanceOfRain: Float;

    public init(day: Day, maxTemp: Float, chanceOfRain: Float) {
        self.day = day
        self.maxTemp = maxTemp
        self.chanceOfRain = chanceOfRain
    }
}
