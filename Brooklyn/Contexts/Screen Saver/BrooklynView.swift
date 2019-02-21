//
//  BrooklynView.swift
//  Brooklyn
//
//  Created by Pedro Carrasco on 30/10/2018.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import Foundation
import ScreenSaver
import AVKit

// MARK: - BrooklynView
final class BrooklynView: ScreenSaverView {

    // MARK: Local Typealias
    typealias Static = BrooklynView
    
    // MARK: Constant
    private enum Constant {
        static let secondPerFrame = 1.0 / 30.0
    }
    
    // MARK: Outlets
    private let videoLayer = AVPlayerLayer()
    
    // MARK: Properties
    private let animationsManager = AnimationsManager()
    private lazy var preferences = PreferencesWindowController(windowNibName: PreferencesWindowController.identifier)

    // MARK: Initialization
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)

        configure()
    }
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)

        self.animationTimeInterval = Constant.secondPerFrame
        configure()
    }
}

// MARK: - Lifecycle
extension BrooklynView {
    
    override func startAnimation() {
        super.startAnimation()

        animationsManager.player.play()
    }
    
    override func stopAnimation() {
        super.stopAnimation()
        
        animationsManager.player.pause()
    }
}

// MARK: - Configuration
private extension BrooklynView {
    
    func configure() {
        defineLayer()
        setupLayer()
    }
    
    func defineLayer() {
        wantsLayer = true
        defineVideoLayer()
        layer = videoLayer
    }
    
    func setupLayer() {
        videoLayer.player = animationsManager.player
    }
}

// MARK: - Define Layers
private extension BrooklynView {

    func defineVideoLayer() {
        videoLayer.frame = bounds
        videoLayer.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        videoLayer.needsDisplayOnBoundsChange = true
        videoLayer.contentsGravity = .resizeAspectFill
        videoLayer.backgroundColor = NSColor.black.cgColor
    }
}

// MARK: - Preferences
extension BrooklynView {

    override var hasConfigureSheet: Bool {
        return true
    }

    override var configureSheet: NSWindow? {
        return preferences.window
    }
}
