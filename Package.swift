import PackageDescription

let package = Package(
    name: "shorts-salad",
    targets: [
        Target(name: "shorts-salad", dependencies: [])
    ],
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 4),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 4),
        .Package(url: "https://github.com/IBM-Swift/Kitura-Request.git", majorVersion: 0)
    ]
)
