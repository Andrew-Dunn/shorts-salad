//
// Created by andrew on 29/01/17.
//

import Foundation
import Kitura
import KituraRequest
import LoggerAPI

public let showSlackLink: RouterHandler = {request, response, next in
    try response.send("").end()
    var params = [String: String]()
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
                              encoding: JSONEncoding.default)
                     .response { request, response, data, error in
                     }
    }
}
