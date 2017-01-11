//
// Created by andrew on 11/01/17.
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

do {
    HeliumLogger.use(LoggerMessageType.info)
    let controller = try Controller()

    let sslConfig = SslConfig(configPath: "config/ssl.json")
    let ssl = SSLConfig(withCACertificateDirectory: nil,
                              usingCertificateFile: sslConfig.getCertPath(),
                                       withKeyFile: sslConfig.getKeyPath(),
                              usingSelfSignedCerts: sslConfig.isSelfSigned(),
                                       cipherSuite: "ALL")

    Log.info(sslConfig.isSelfSigned().description)
    Log.info(sslConfig.getCertPath())
    Log.info(sslConfig.getKeyPath())

    Kitura.addHTTPServer(onPort: controller.port, with: controller.router, withSSL: ssl)
    Log.info("Made it here!")
    Kitura.run()
    Log.info("And here!?")
} catch let error {
    Log.info(error.localizedDescription)
    Log.info("Oops... something went wrong. Server did not start!")
}