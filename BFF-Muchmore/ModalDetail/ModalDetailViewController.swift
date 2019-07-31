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
       
    }
    
    @IBAction func voltarButton(_ sender: UIButton) {
        if let navigation = self.navigationController{
            navigation.popToRootViewController(animated: true)
        }
        
    }
    
}
