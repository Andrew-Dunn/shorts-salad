//
// Created by andrew on 12/01/17.
//

import Foundation
import Kitura
import SwiftyJSON
import LoggerAPI

class MainController {
    let router: Router

    var port: Int {
        get {
            return 8091
        }
    }

    var url: String {
        get {
            return "0.0.0.0"
        }
    }

    init() throws {
        let slackRouter = Router()
        slackRouter.post("/show-salad-link", handler: showSlackLink)
        router = Router()
        router.all("/") { request, response, next in
            if request.method == .post {
                Log.info(try request.readString()!)
            }

            try response.send(output).end()
        }
        router.all("/slack", middleware: slackRouter)
        router.all("/tests", handler: runTests)
    }
}
