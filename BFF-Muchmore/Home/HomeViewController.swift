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
    @IBOutlet weak var programTitle: UILabel!
    
    
    var flag = true
    let url = "http://stream0.wfmu.org/freeform-high.aac"
    var player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.loadPage()
        let playerItem = AVPlayerItem( url:NSURL( string:url )! as URL )
        playerItem.addObserver(self, forKeyPath: "timedMetadata", options: NSKeyValueObservingOptions(), context: nil)
        player = AVPlayer(playerItem:playerItem)
        player.rate = 1.0;
        player.play()
     
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath != "timedMetadata" { return }
        
        let data: AVPlayerItem = object as! AVPlayerItem
        
        for item in data.timedMetadata! {
            print("Playing now: \(item.value!)")
            self.programTitle.text = (item.value! as! String)
        }
        
    }
    
    @IBAction func playPause(_ sender: UIButton) {
        if flag == true {
            flag = false
           
           player.pause()
            
        }else{
            flag = true
            player.play()
            
        }
    }

 
    
    
}
    
    
    


