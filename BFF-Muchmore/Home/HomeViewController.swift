//
//  ViewController.swift
//  BFF-Muchmore
//
//  Created by Haziel Leite Farias on 17/07/19.
//  Copyright © 2019 Haziel. All rights reserved.
//

extension NSNotification.Name {
    static let globalVariableChanged = NSNotification.Name(Bundle.main.bundleIdentifier! + ".globalVariable")
}

var playingNowGlobal: String = "-" {
    didSet {
        NotificationCenter.default.post(name: .globalVariableChanged, object: nil)
    }
}

import UIKit
import AVFoundation
import MediaPlayer

class HomeViewController: UIViewController {
    
    @IBOutlet weak var buttonPlayPause: UIButton!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var programTitleTop: UILabel!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet var artist: UILabel!
    @IBOutlet var program: UILabel!
    
    var flagPlay = true
    let url = "http://stream0.wfmu.org/freeform-high.aac"
    var player = AVPlayer()
    let commandCenter = MPRemoteCommandCenter.shared()
    override func viewDidLoad() {
        super.viewDidLoad()
        setSession()
        //UIApplication.shared.beginReceivingRemoteControlEvents()
        setupMediaCommands()
        player = AVPlayer(playerItem:generatePlayerItem())
        player.play()
        
        
    }
    
    func setSession(){
        do{
            //try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.allowAirPlay, .mixWithOthers])
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session Active")
            //try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func setupMediaCommands(){
        
        commandCenter.pauseCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            //Update your button here for the pause command
            print("pause")
            
            return .success
        }
        
        commandCenter.playCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            //Update your button here for the play command
            print("play")
            
            return .success
        }
    }
    /*
    func setupNotificationView(){
        let nowPlayingInfo:MPNowPlayingInfoCenter
        
    }
    */
    func generatePlayerItem() -> AVPlayerItem{
        let playerItem = AVPlayerItem( url:NSURL( string:url )! as URL )
        playerItem.addObserver(self, forKeyPath: "timedMetadata", options: NSKeyValueObservingOptions(), context: nil)
        return playerItem
    }
    
    func reload() {
        self.trackTitle.text = "Loading..."
        self.programTitleTop.text = "Loading..."
        playingNowGlobal="Loading..."
        player.currentItem?.removeObserver(self, forKeyPath: "timedMetadata", context: nil)
        player.replaceCurrentItem(with: generatePlayerItem())
        player.play()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath != "timedMetadata" { return }
        
        let data: AVPlayerItem = object as! AVPlayerItem
        if data.timedMetadata != nil {
            for item in data.timedMetadata! {
                let itemValor = item.value as! NSString
                var metadataList:Array<String> = itemValor.components(separatedBy: " on WFMU on ")
                print("Playing now: \(item.value!)")
                
                if metadataList.count == 2{
                    let bandTrack:Array<String> = metadataList[0].components(separatedBy: "\" by ")
                    if bandTrack.count == 2{
                        var track = bandTrack[0]
                        
                        if track.starts(with: "\"") {
                            track.remove(at: track.startIndex)
                        }
                        
                        self.trackTitle.text = track
                        self.artist.text = bandTrack[1]
                        self.programTitleTop.text = track
                        playingNowGlobal=track
                    }
                    else{
                        let track = bandTrack[0]
                        playingNowGlobal=track
                        self.programTitleTop.text = track
                        self.trackTitle.text = track
                        self.artist.text = ""
                    }
                    self.program.text = metadataList[1]
                    
                }
                else{
                    self.trackTitle.text = metadataList[0]
                    self.artist.text = ""
                    self.program.text = ""
                    self.programTitleTop.text = metadataList[0]
                    playingNowGlobal=metadataList[0]
                }
            }
        }
    }
    
    @IBAction func playPause(_ sender: UIButton) {
        if flagPlay == true {
            pauseButton()
        }else{
            playButton()
        }
    }
    
    func playButton(){
        flagPlay = true
        buttonPlayPause.setImage(UIImage(named: "pause.png"), for: UIControl.State.normal)
        self.reload()
    }
    
    func pauseButton(){
        flagPlay = false
        player.pause()
        self.program.text = " "
        self.artist.text = " "
        self.trackTitle.text = "-"
        self.programTitleTop.text = "-"
        playingNowGlobal="-"
        buttonPlayPause.setImage(UIImage(named: "play.png"), for: UIControl.State.normal)
    }
    
    
    /*
    override func remoteControlReceived(with event: UIEvent?) {
        let rc = event!.subtype
        print("rc.rawValue: \(rc.rawValue)")
        if event!.type == UIEvent.EventType.remoteControl{
            if event!.subtype == UIEvent.EventSubtype.remoteControlPause{
                print("pause")
                pauseButton()
              
            }
            if event!.subtype == UIEvent.EventSubtype.remoteControlPlay{
                print("play")
                playButton()
            }}
    }*/
    
    
    
    
}
