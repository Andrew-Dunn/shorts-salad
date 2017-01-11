//
// Created by andrew on 12/01/17.
//

import Foundation
import Kitura

class MainController {
    let router: Router

    var port: Int {
        get { return 8091 }
    }

    var url: String {
        get { return "0.0.0.0" }
    }

    init() throws {
        router = Router()
        router.all("/", middleware: StaticFileServer())
    }
}
