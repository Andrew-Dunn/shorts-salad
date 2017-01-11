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
    let publicHttpsPort: Int;

    init(configPath: String) {
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: configPath,
                                                        isDirectory: false))
            let json = JSON(data: jsonData)

            selfSigned = json["selfSigned"].bool!
            keyPath = json["keyPath"].string!
            certPath = json["certPath"].string!

            if (json["port"].int != nil) {
                publicHttpsPort = json["port"].int!
            } else {
                publicHttpsPort = 443
            }
        } catch let error as NSError {
            Log.error("error loading contentsOf url \(configPath)")
            Log.error(error.localizedDescription)
            selfSigned = false
            keyPath = ""
            certPath = ""
            publicHttpsPort = 443
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

    func getHttpsPort() -> Int {
        return publicHttpsPort;
    }
}
