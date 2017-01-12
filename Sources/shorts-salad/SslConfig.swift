//
// Created by andrew on 12/01/17.
//

import Foundation
import SwiftyJSON
import LoggerAPI

internal class SslConfig {
    // JSON Keys.
    static let selfSignedKey = "selfSigned"
    static let caPathKey = "caPath"
    static let certPathKey = "certPath"
    static let keyPathKey = "keyPath"
    static let httpsPortKey = "port"

    // Default HTTPS Port.
    static let defaultHttpsPort = 443

    // Configurable settings.
    let selfSigned: Bool;
    let keyPath: String;
    let caPath: String?;
    let certPath: String;
    let publicHttpsPort: Int;

    // State.
    let enabled: Bool;

    init(configPath: String) {
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: configPath,
                                                        isDirectory: false))
            let json = JSON(data: jsonData)

            selfSigned = json[selfSignedKey].bool!
            keyPath = json[keyPathKey].string!
            certPath = json[certPathKey].string!

            if (json[httpsPortKey].int != nil) {
                publicHttpsPort = json[httpsPortKey].int!
            } else {
                publicHttpsPort = defaultHttpsPort
            }

            if (json[caPathKey].string != nil) {
                caPath = json[caPathKey].string!
            } else {
                caPath = nil
            }
            enabled = true;
        } catch let error as Error {
            Log.warning("Could not load SSL config at \(configPath)")
            selfSigned = false
            keyPath = ""
            caPath = nil
            certPath = ""
            publicHttpsPort = defaultHttpsPort
            enabled = false
        }
    }

    func isSelfSigned() -> Bool {
        return selfSigned
    }

    func getCAPath() -> String? {
        return caPath
    }

    func getCertPath() -> String {
        return certPath
    }

    func getKeyPath() -> String {
        return keyPath
    }

    func getHttpsPort() -> Int? {
        if (enabled) {
            return publicHttpsPort
        } else {
            return nil
        }
    }

    func isEnabled() -> Bool {
        return enabled
    }
}
