//
//  ViewController.swift
//  BFF-Muchmore
//
//  Created by Haziel Leite Farias on 17/07/19.
//  Copyright © 2019 Haziel. All rights reserved.
//

import UIKit
import AVFoundation
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player = AVPlayer(playerItem:generatePlayerItem())
        player.play()
    }
    
    func generatePlayerItem() -> AVPlayerItem{
        let playerItem = AVPlayerItem( url:NSURL( string:url )! as URL )
        playerItem.addObserver(self, forKeyPath: "timedMetadata", options: NSKeyValueObservingOptions(), context: nil)
        return playerItem
    }
    
    func reload() {
        self.trackTitle.text = "Loading..."
        self.programTitleTop.text = "Loading..."
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
                let bandTrack = metadataList[0].components(separatedBy: "\" by ")
                var track = bandTrack[0]
                
                if track.starts(with: "\"") {
                    track.remove(at: track.startIndex)
                }
                
                
                print("Playing now: \(item.value!)")
                
                self.trackTitle.text = track
                self.artist.text = bandTrack[1]
                self.program.text = metadataList[1]
                self.programTitleTop.text = (track)
            }
        }
    }
    
    @IBAction func playPause(_ sender: UIButton) {
        if flagPlay == true {
            flagPlay = false
            player.pause()
            self.program.text = ""
            self.artist.text = ""
            self.trackTitle.text = "-"
            self.programTitleTop.text = "-"
            buttonPlayPause.setImage(UIImage(named: "play.png"), for: UIControl.State.normal)
        }else{
            flagPlay = true
            buttonPlayPause.setImage(UIImage(named: "pause.png"), for: UIControl.State.normal)
            self.reload()
        }
    }
}
    
    
    


