//
//  ViewController.swift
//  BFF-Muchmore
//
//  Created by Haziel Leite Farias on 17/07/19.
//  Copyright © 2019 Haziel. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var programTitleTop: UILabel!
    @IBOutlet weak var programTitle: UILabel!
    @IBOutlet weak var programDetail: UILabel!
    
    var timer = Timer()
    
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPage()
        if flag == false{
            flag = true
            self.atualizar()
            
        }
    }

  
    
    
    @objc func loadPage(){
        let url = URL(string: "https://data.bff.fm/nowplaying.txt")
        let contentString = try! NSString(contentsOf: url!, encoding: String.Encoding.utf8.rawValue)
        let msgStringFull:Array<String> = contentString.components(separatedBy: "\n")
        var title = msgStringFull[0].components(separatedBy: ":")
        title.remove(at: 0)
        let textTitle = title.joined()
        var detail = msgStringFull[1].components(separatedBy: ":")
        detail.remove(at: 0)
        let textDetail = detail.joined()
        let complement = msgStringFull[2]
        
        
        self.programTitle.text = textTitle
        self.programTitleTop.text = textTitle + " -" + textDetail
        self.programDetail.text = textDetail + "\n" + complement
        
        var image = msgStringFull[4].components(separatedBy: ":")
        image.remove(at: 0)
        image[0]=image[0]+":"
        let imageUrl = image.joined().replacingOccurrences(of: " ", with: "")
        let url2 = URL(string: imageUrl)
        
        if let data = try? Data(contentsOf: url2!){ //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            background.image = UIImage(data: data)
            
        }
       
    }
    
 
    
     func atualizar(){
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(loadPage), userInfo: nil, repeats: true)
        
        
     
     }
    
}
    
    
    


