//
// Created by andrew on 12/01/17.
//

import Foundation
import SwiftyJSON
import LoggerAPI

class SslConfig {
    let selfSigned: Bool;
    let keyPath: String;
    let certPath: String;

    init(configPath: String) {
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: configPath,
                                                        isDirectory: false))
            let json = JSON(data: jsonData)

            selfSigned = json["selfSigned"].bool!
            keyPath = json["keyPath"].string!
            certPath = json["certPath"].string!
        } catch let error as NSError {
            Log.error("error loading contentsOf url \(configPath)")
            Log.error(error.localizedDescription)
            selfSigned = false
            keyPath = ""
            certPath = ""
        }
    }

    func isSelfSigned() -> Bool {
        return selfSigned;
    }

    func getCertPath() -> String {
        return certPath;
    }

    func getKeyPath() -> String {
        return keyPath;
    }
}
