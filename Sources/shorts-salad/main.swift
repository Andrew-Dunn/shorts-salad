//
// Created by andrew on 11/01/17.
//

import Foundation
import Kitura
import HeliumLogger
import LoggerAPI

do {
    HeliumLogger.use(LoggerMessageType.info)
    let sslConfig = SslConfig(configPath: "config/ssl.json")

    let httpController = try HttpController(publicHttpsPort: sslConfig.getHttpsPort())
    let mainController = try MainController()

    Kitura.addHTTPServer(onPort: httpController.port, with: httpController.router)

    if (sslConfig.isEnabled()) {
        let ssl = SSLConfig(withCACertificateFilePath: sslConfig.getCAPath(),
                            usingCertificateFile: sslConfig.getCertPath(),
                            withKeyFile: sslConfig.getKeyPath(),
                            usingSelfSignedCerts: sslConfig.isSelfSigned(),
                            cipherSuite: "ALL")

        Log.info(sslConfig.isSelfSigned().description)
        Log.info(sslConfig.getCertPath())
        Log.info(sslConfig.getKeyPath())

        Kitura.addHTTPServer(onPort: mainController.port, with: mainController.router, withSSL: ssl)
    }

    Kitura.run()
} catch let error {
    Log.info(error.localizedDescription)
    Log.info("Oops... something went wrong. Server did not start!")
}