//
//  AudioPlayer.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 10.01.2022.
//

import Foundation
import AVFoundation

protocol AudioPlayerInput {
	func playSound(by url: URL?)
}

final class AudioPlayer: AudioPlayerInput {
	private var player: AVPlayer!
	
	func playSound(by url: URL?) {
		guard let url = url else { return }
		let playerItem: AVPlayerItem = AVPlayerItem(url: url)
		player = AVPlayer(playerItem: playerItem)
		player.volume = 1.0
		player.play()
	}
}
