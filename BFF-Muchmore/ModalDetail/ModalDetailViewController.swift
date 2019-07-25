//
//  ModalDetailViewController.swift
//  BFF-Muchmore
//
//  Created by Haziel Farias on 17/07/19.
//  Copyright © 2019 Haziel. All rights reserved.
//

import UIKit


class ModalDetailViewController: UIViewController {

    @IBOutlet weak var programTitleTop: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var imageProgram: UIImageView!
    @IBOutlet weak var sinopse: UILabel!
    @IBOutlet weak var programTitle: UILabel!
    @IBOutlet weak var programDetail: UILabel!
    
    var programa:ProgramData? = nil
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let program = programa{
            imageProgram.image = UIImage(named: program.imageAdress)
            background.image = UIImage(named: program.imageAdress)
            sinopse.text = program.sinopse
            programTitle.text = program.title
            programDetail.text = program.detail
        }
        
        //self.loadPage()
     
       
    }
    
    @IBAction func voltarButton(_ sender: UIButton) {
        if let navigation = self.navigationController{
            navigation.popToRootViewController(animated: true)
        }
        
    }
    /*
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
        
        self.programTitleTop.text = textTitle + " -" + textDetail
      
      
    }*/

    
    
}
