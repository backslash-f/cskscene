import SpriteKit

public extension CSKScene {

    /// The "highest `SKScene` point" converted from the "highest `SKView` point".
    var viewTop: CGFloat {
        guard let skView = view else {
            return .zero
        }
        return convertPoint(fromView: highestScenePoint(in: skView)).y
    }

    /// The "lowest `SKScene` point" converted from the "lowest`SKView` point".
    var viewBottom: CGFloat {
        guard let skView = view else {
            return .zero
        }
        return convertPoint(fromView: lowestScenePoint(in: skView)).y
    }

    /// The "leftmost `SKScene` point" converted from the "leftmost`SKView` point".
    var viewLeft: CGFloat {
        convertPoint(fromView: .zero).x
    }

    /// The "rightmost `SKScene` point" converted from the "rightmost`SKView` point".
    var viewRight: CGFloat {
        guard let view = view else {
            return .zero
        }
        let point = CGPoint(x: view.bounds.size.width, y: .zero)
        return convertPoint(fromView: point).x
    }

    #if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)
    /// The insets used to determine the safe area of the window.
    var insets: UIEdgeInsets {
        UIApplication.shared.delegate?.window??.safeAreaInsets ?? .zero
    }
    #endif
}

// MARK: - Private

private extension SKScene {

    // MARK: Coordinate System

    /*
     macOS uses a different coordinate systems. These functions handle that.
     */

    func highestScenePoint(in skView: SKView) -> CGPoint {
        let topY: CGPoint
        #if os(iOS) || os(tvOS) || os(watchOS)
        topY = .zero
        #elseif os(OSX)
        topY = CGPoint(x: .zero, y: skView.bounds.size.height)
        #endif
        return topY
    }

    func lowestScenePoint(in skView: SKView) -> CGPoint {
        let bottomY: CGPoint
        #if os(iOS) || os(tvOS) || os(watchOS)
        bottomY = CGPoint(x: .zero, y: skView.bounds.size.height)
        #elseif os(OSX)
        bottomY = .zero
        #endif
        return bottomY
    }
}
