//
//  ProgrammingViewController.swift
//  WFMU-TDS
//
//  Created by Haziel Leite Farias on 17/07/19.
//  Copyright © 2019 Haziel. All rights reserved.
//

import UIKit
import AVFoundation

class ProgrammingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
   
    @IBOutlet weak var programTitleTop: UILabel!
    @IBOutlet weak var tableProgramming: UITableView!
    @IBOutlet weak var background: UIImageView!

    private var observer: NSObjectProtocol!
    
    let lista:Array<ProgramData> = [ProgramData(title: "Programa diário", detail: "Começa as 8h termina as 20h", imageAdress: "imagem-programa.png", sinopse: "uni duni tê salame mingue")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableProgramming.dataSource = self
        self.tableProgramming.delegate = self
        self.programTitleTop.text = playingNowGlobal
        observer = NotificationCenter.default.addObserver(forName: .globalVariableChanged, object: nil, queue: .main) { [weak self] notification in
            // do something with globalVariable here
            self?.programTitleTop.text = playingNowGlobal
        }
    }
    
    deinit {
        // remember to remove it when this object is deallocated
        NotificationCenter.default.removeObserver(observer!)
    }

      
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProgramming", for: indexPath) as! TableViewCell
        let atualProgram = lista[indexPath.row]
        cell.programTitle.text = atualProgram.title
        cell.programDetail.text = atualProgram.detail
        cell.programImage.image = UIImage(named: atualProgram.imageAdress)
        cell.backgroundColor = UIColor.clear
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath)
        
            showSinopse(programa: lista[indexPath.row])
            cell?.isSelected = false
    }
    
    @objc func showSinopse(programa:ProgramData){
    
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "modalDetail") as! ModalDetailViewController
                controller.programa = programa
             
                self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}
