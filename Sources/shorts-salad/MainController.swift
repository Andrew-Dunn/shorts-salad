//
// Created by andrew on 12/01/17.
//

import Foundation
import Kitura
import KituraRequest

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
        router = Router()
        router.get("/") { request, response, next in
            try response.send("Hello World, from Kitura!").end()
        }
        router.post("/slack/show-salad-link") { request, response, next in
            try response.send("").end()

            let responseURL = request.body?.asJSON?["response_url"].string
            if responseURL != nil {
                let message = "<https://\(request.hostname)|:middle_finger::jeans:.ws>"
                KituraRequest.request(.post,
                                      responseURL!,
                                      parameters: [
                                          "response_type": "in_channel",
                                          "attachments": [
                                              "fallback": message,
                                              "pretext": message
                                          ]
                                      ],
                                      encoding: JSONEncoding.default)
            }
        }
    }
}
