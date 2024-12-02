//
//  AVPlayer +Bing.swift
//  Project2
//
//  Created by Aswathimol S(UST,IN) on 20/09/23.
//

import Foundation
import AVFoundation

extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
}

