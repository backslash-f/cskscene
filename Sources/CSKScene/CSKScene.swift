import Combine
import GCOverseer
import SpriteKit

/// A **custom** `SKScene` subclass with debug options enabled by default and an instance of `GCOverseer`.
public class CSKScene: SKScene {

    let debugSettings: DebugSettings

    let gcOverseer = GCOverseer()

    var cancellables = Set<AnyCancellable>()

    // MARK: Internal Properties

    /// Enables / disables logging output to both *Xcode's Console* and the macOS *Console app*. `true` by default.
    internal var isLoggingEnabled: Bool = true

    // MARK: - Lifecycle

    public init(size: CGSize, debugSettings: DebugSettings = DebugSettings()) {
        self.debugSettings = debugSettings
        super.init(size: size)
    }

    public required init?(coder aDecoder: NSCoder) {
        self.debugSettings = DebugSettings()
        super.init(coder: aDecoder)
    }
}

// MARK: - SpriteKit

public extension CSKScene {

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupDebugSettings()
        logInformation()
    }
}

// MARK: - Private

private extension CSKScene {

    func setupDebugSettings() {
        #if DEBUG
        view?.showsFPS          = debugSettings.showsFPS
        view?.showsFields       = debugSettings.showsFields
        view?.showsPhysics      = debugSettings.showsPhysics
        view?.showsDrawCount    = debugSettings.showsDrawCount
        view?.showsNodeCount    = debugSettings.showsNodeCount
        view?.showsQuadCount    = debugSettings.showsQuadCount
        #endif
    }

    func logInformation() {
        log(information: "Scene size: \(size)", category: .sklifecycle)
    }
}
