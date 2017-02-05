//
// Created by andrew on 5/02/17.
//

import Foundation

public struct Outfit {
    private let day: Day
    private let competitor: Competitor
    private let clothing: Clothing

    public init(on day: Day, competitor: Competitor, wore clothing: Clothing)
    {
        self.day = day
        self.competitor = competitor
        self.clothing = clothing
    }
}
