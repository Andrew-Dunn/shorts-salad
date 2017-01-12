//
// Created by andrew on 12/01/17.
//

import Foundation
import Kitura
import LoggerAPI

class HttpController {
    let router: Router
    let publicHttpsPort: Int?

    var port: Int {
        get { return 8090 }
    }

    var url: String {
        get { return "0.0.0.0" }
    }

    init(publicHttpsPort: Int?) throws {
        self.publicHttpsPort = publicHttpsPort
        router = Router()
        router.get("/\\.well-known/acme-challenge/",
                   middleware: StaticFileServer(path: "/tmp/shorts-salad/.well-known/acme-challenge/"))
        if (publicHttpsPort != nil) {
            router.all("/(?!\\.well-known/acme-challenge/).+", handler: redirectToHttps)
        } else {
            router.all("/", middleware: StaticFileServer())
        }
    }

    public func redirectToHttps(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) throws {
        Log.debug("GET - /hello route handler...")
        response.headers["Content-Type"] = "text/plain; charset=utf-8"
        var httpsPath = "https://"
        httpsPath += request.hostname
        if (publicHttpsPort! != 443) {
            httpsPath += ":" + publicHttpsPort!.description
        }
        httpsPath += request.urlURL.path
        if (request.urlURL.query != nil) {
            httpsPath += "?" + request.urlURL.query!
        }
        try response.redirect(httpsPath, status: .movedPermanently)
    }
}
