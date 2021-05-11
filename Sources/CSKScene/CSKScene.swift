import Combine
import GCOverseer
import SpriteKit

/// A **custom** `SKScene` subclass with debug options enabled by default and an instance of `GCOverseer`.
open class CSKScene: SKScene {

    // MARK: - Properties

    public var debugSettings = DebugSettings() {
        didSet {
            updateDebugSettings()
        }
    }

    public var cancellables = Set<AnyCancellable>()

    public let gcOverseer = GCOverseer()

    // MARK: Internal Properties

    /// Enables / disables logging output to both *Xcode's Console* and the macOS *Console app*. `true` by default.
    internal static var isLoggingEnabled: Bool = true

    // MARK: - Lifecycle

    public init(size: CGSize, debugSettings: DebugSettings = DebugSettings()) {
        self.debugSettings = debugSettings
        super.init(size: size)
    }

    required public init?(coder aDecoder: NSCoder) {
        self.debugSettings = DebugSettings()
        super.init(coder: aDecoder)
    }
}

// MARK: - SpriteKit

extension CSKScene {

    open override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        logSceneSize()
    }

    open override func didMove(to view: SKView) {
        super.didMove(to: view)
        updateDebugSettings()
        setupDefaultViewOptions()
    }
}

// MARK: - Private

private extension CSKScene {

    func updateDebugSettings() {
        #if DEBUG
        view?.showsFPS          = debugSettings.showsFPS
        view?.showsFields       = debugSettings.showsFields
        view?.showsPhysics      = debugSettings.showsPhysics
        view?.showsDrawCount    = debugSettings.showsDrawCount
        view?.showsNodeCount    = debugSettings.showsNodeCount
        view?.showsQuadCount    = debugSettings.showsQuadCount
        #endif
    }

    func setupDefaultViewOptions() {
        view?.ignoresSiblingOrder = true
        #if os(iOS)
        view?.isMultipleTouchEnabled = true
        #endif
    }

    func logSceneSize() {
        CSKScene.log(information: "Scene size: \(size)", category: .sklifecycle)
    }
}
