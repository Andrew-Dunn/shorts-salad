//
// Created by andrew on 11/01/17.
//

import Foundation
import Kitura

do {
    let controller = try Controller()
    Kitura.addHTTPServer(onPort: controller.port, with: controller.router)
    Kitura.run()
} catch let error {
    print(error.localizedDescription)
    print("Oops... something went wrong. Server did not start!")
}