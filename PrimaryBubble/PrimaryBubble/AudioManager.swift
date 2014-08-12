//
//  AudioManager.swift
//  PrimaryBubble
//
//  Created by Thiago Amanajas on 8/8/14.
//  Copyright (c) 2014 Thiago Amanajas. All rights reserved.
//

import Foundation
import AVFoundation

class AudioManager {
    
    private var backgroundMusicPlayer:AVAudioPlayer = AVAudioPlayer()
    
    func playSound(audioName:String, audioExtension:String, loops:Int){
        
        var bgMusic:NSURL = NSBundle.mainBundle().URLForResource(audioName, withExtension: audioExtension)
        backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusic, error: nil)
        backgroundMusicPlayer.numberOfLoops = loops
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
    }
}