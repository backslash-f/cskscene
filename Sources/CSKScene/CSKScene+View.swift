import Foundation
import GameplayKit
import class Foundation.Bundle

public extension CSKScene {

    /// Loads the `GKScene`'s root node and returns it as `SKScene`.
    ///
    /// Notice: the class name must match the filename.
    /// E.g.: for a class named `StartScene`, the function tries to load a file named `StartScene.sks`.
    ///
    /// - Returns: The root node of a `GKScene` as a `SKScene` instance.
    static func makeScene<T: SKScene>() -> T {

        let filename = String(describing: self)

        // Load a GKScene object from a SKS file.
        guard let gkScene = GKScene(fileNamed: filename) else {
            let errorMessage = "Could not load \"\(filename).sks\" as a \"GKScene\" object"
            CSKScene.logError(errorMessage)
            fatalError(errorMessage)
        }

        // Load the GKScene's root node as a SKScene.
        guard let skScene = gkScene.rootNode as? T else {
            let errorMessage = "Could not load the \"GKScene's root node\" as a \"SKScene\""
            CSKScene.logError(errorMessage)
            fatalError(errorMessage)
        }

        return skScene
    }
}
