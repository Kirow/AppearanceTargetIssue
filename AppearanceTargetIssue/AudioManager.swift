//
// Created by KirowOnet on 10/18/17.
// Copyright (c) 2017 Home. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

public class AudioManager: NSObject {

    private enum SystemSound: UInt32 {
        case click = 1104
        case caution = 1054
        case successSearch = 1110
        case vibration = 4095
    }

    static let manager = AudioManager()

    private func playSystemSound(with id: SystemSound) {
        AudioServicesPlaySystemSound(SystemSoundID(id.rawValue))
    }

    @objc func playStandardClickSound() {
        playSystemSound(with: .click)
    }

    func turnSound(state: Bool) {
        UIButton.appearance().isSoundEnabled = state
        UISwitch.appearance().isSoundEnabled = state
    }

    deinit {
        let sounds: [SystemSound] = [.click, .successSearch, .caution, .vibration]
        for soundItem in sounds {
            AudioServicesDisposeSystemSoundID(soundItem.rawValue)
        }
    }
}

extension UIControl {
    var isSoundEnabled: Bool {
        get {
            return target(forAction: #selector(AudioManager.playStandardClickSound), withSender: nil) != nil ? true : false
        }
        set {
            if newValue {
                addTarget(AudioManager.manager, action: #selector(AudioManager.playStandardClickSound), for: .touchUpInside)
            } else {
                removeTarget(AudioManager.manager, action: #selector(AudioManager.playStandardClickSound), for: .touchUpInside)
            }
        }
    }
}