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
                Log.info(try request.readString()!)
            }
            try response.send("Hello World, from Kitura!").end()
        }
        router.post("/slack/show-salad-link") { request, response, next in
            try response.send("").end()
            var params = [String:String]()
            let rawData = try request.readString()
            rawData!.components(separatedBy: "&").forEach { line in
                let parts = line.components(separatedBy: "=")
                params[parts[0]] = parts[1].removingPercentEncoding
            }
            let responseURL = params["response_url"]
            if responseURL != nil {
                let message = "<https://\(request.hostname)|:middle_finger::jeans:.ws>"
                Log.info("Sending message to: \(responseURL)")
                KituraRequest.request(.post,
                                      responseURL!,
                                      parameters: [
                                          "response_type": "in_channel",
                                          "attachments": [
                                              [
                                                  "fallback": message,
                                                  "pretext": message
                                              ]
                                          ]
                                      ],
                                      encoding: JSONEncoding.default).response {
                    request, response, data, error in
                }
            }
        }
    }
}
