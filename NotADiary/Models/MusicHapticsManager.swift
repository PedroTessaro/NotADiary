//
//  MusicHapticsManager.swift
//  NotADiary
//
//  Created by Enzo Ferroni on 17/10/25.
//

import Foundation
import MediaAccessibility
import Observation

@Observable
@MainActor
class MusicHapticsManager {
    var isHapticsActive: Bool = false
    var isHapticsAvailable: Bool = false
    
    private let manager = MAMusicHapticsManager.shared
    
    @ObservationIgnored
    private var statusObserver: NSObjectProtocol?
    
    init() {
        setupHapticsMonitoring()
    }
    
    private func setupHapticsMonitoring() {
        isHapticsActive = manager.isActive
        
        statusObserver = NotificationCenter.default.addObserver(
            forName: MAMusicHapticsManager.activeStatusDidChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                self.isHapticsActive = self.manager.isActive
            }
        }
    }
    
    func checkHapticAvailability(for isrc: String) async {
        
        await withCheckedContinuation { continuation in
            manager.checkHapticTrackAvailabilityForMedia(
                matchingCode: isrc
            ) { available in
                Task { @MainActor in
                    self.isHapticsAvailable = available
                    continuation.resume()
                }
            }
        }
    }
    
    deinit {
        if let observer = statusObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
