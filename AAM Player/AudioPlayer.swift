//
//  AudioPlayer.swift
//  AAM Player
//
//  Created by Дмитрий on 08.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation
import AVFoundation

enum Status{
    case play
    case pause
    case stop
}

public func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
    let dispatchTime = DispatchTime.now() + seconds
    dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
}

public enum DispatchLevel {
    case main, userInteractive, userInitiated, utility, background
    var dispatchQueue: DispatchQueue {
        switch self {
        case .main:                 return DispatchQueue.main
        case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
        case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
        case .utility:              return DispatchQueue.global(qos: .utility)
        case .background:           return DispatchQueue.global(qos: .background)
        }
    }
}

class AudioPlayer: ObservableObject {
    var player = AVPlayer()
    var playlistForPlayer: PlaylistForPlayer?
    @Published var currentItemID: UUID?
    @Published var statusPlayer = Status.stop
    var currentTimePause: Int16 = 0
    
    @Published var playerFinidhed = false
    
    func getStatusPlayer() -> Status{
        return statusPlayer
    }
    func getCurrentItemID() -> UUID?{
        return currentItemID
    }
    
    
    @objc func playerDidFinishPlaying(sender: Notification) {
        currentItemID = nil
        statusPlayer = .stop
        if let playlistForPlayer = playlistForPlayer{
            initPlayer(itemId: playlistForPlayer)
            delay(bySeconds: Double(self.currentTimePause)) {
                self.play()
            }
        }
        
    }
    
    func initPlayer(itemId : PlaylistForPlayer) {
        if currentItemID != nil{
            guard currentItemID != itemId.queue.first?.id else{
                return
            }
        }
        
        playlistForPlayer = itemId
        
        if (playlistForPlayer?.queue.isEmpty)!{
            return
        }
        
        guard let soundToPlay = playlistForPlayer?.queue.removeFirst() else{
            return
        }
        
        currentItemID = soundToPlay.id
        currentTimePause = soundToPlay.pause
        guard let url = URL.init(string: soundToPlay.sound) else {
            fatalError("URL can't get from String")
            //return
        }
        let playerItem = AVPlayerItem.init(url: url)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        player = AVPlayer.init(playerItem: playerItem)
        playAudioBackground()
    }
    
    func playAudioBackground() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [.mixWithOthers, .allowAirPlay])
            //print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            //print("Session is Active")
        } catch {
            print(error)
        }
    }
    
    func pause(){
        statusPlayer = .pause
        player.pause()
    }
    
    func play() {
        statusPlayer = .play
        player.play()
    }
}
