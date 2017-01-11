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
    let enabled: Bool;

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
            enabled = true;
        } catch let error as Error {
            Log.warning("Could not load SSL config at \(configPath)")
            selfSigned = false
            keyPath = ""
            certPath = ""
            publicHttpsPort = 443
            enabled = false
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

    func getHttpsPort() -> Int? {
        if (enabled) {
            return publicHttpsPort;
        } else {
            return nil;
        }
    }

    func isEnabled() -> Bool {
        return enabled;
    }
}
