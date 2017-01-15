//
// Created by andrew on 12/01/17.
//

import Foundation
import Kitura
import KituraRequest
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
        router = Router()
        router.all("/") { request, response, next in
            if request.method == .post {
                Log.info((request.body?.asText)!)
            }
            try response.send("Hello World, from Kitura!").end()
        }
        router.post("/slack/show-salad-link") { request, response, next in
            try response.send("").end()
            var rawJson = Data()
            try request.read(into: &rawJson)
            let json = JSON(data: rawJson)
            let responseURL = json["response_url"].string
            if responseURL != nil {
                let message = "<https://\(request.hostname)|:middle_finger::jeans:.ws>"
                Log.info("Response URL: \(responseURL)")
                KituraRequest.request(.post,
                                      responseURL!,
                                      parameters: [
                                          "response_type": "in_channel",
                                          "attachments": [
                                              "fallback": message,
                                              "pretext": message
                                          ]
                                      ],
                                      encoding: JSONEncoding.default).response {
                    request, response, data, error in
                }
            }
        }
    }
}
