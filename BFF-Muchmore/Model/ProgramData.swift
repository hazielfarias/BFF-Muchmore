//
//  ProgramData.swift
//  BFF-Muchmore
//
//  Created by Haziel Leite Farias on 17/07/19.
//  Copyright © 2019 Haziel. All rights reserved.
//

import UIKit

class ProgramData: NSObject {
    
    let title:String
    let detail:String
    let imageAdress:String
    let sinopse:String
    
    init(title: String, detail: String, imageAdress: String, sinopse: String) {
        self.title = title
        self.detail = detail
        self.imageAdress = imageAdress
        self.sinopse = sinopse
        super.init()
    }
}
