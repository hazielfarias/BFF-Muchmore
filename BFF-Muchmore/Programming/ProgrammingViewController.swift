//
//  ProgrammingViewController.swift
//  BFF-Muchmore
//
//  Created by Haziel Leite Farias on 17/07/19.
//  Copyright © 2019 Haziel. All rights reserved.
//

import UIKit

class ProgrammingViewController: UIViewController, UITableViewDataSource{
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var programTitleTop: UILabel!
    @IBOutlet weak var tableProgramming: UITableView!
    @IBOutlet weak var background: UIImageView!
    
    let lista:Array<ProgramData> = [ProgramData(title: "Programa diário", detail: "Começa as 8h termina as 20h", imageAdress: "imagem-programa.png", sinopse: "uni duni tê salame mingue"), ProgramData(title: "Programa da madruga com nome grande", detail: "Começa as 20h termina as 8h", imageAdress: "capa-teste.jpg", sinopse: "uni duni tê salame mingue oajsdiasdijaisd asjdiadjsia iajsdiajds ajsdiasd aisdj iasdjiasdj iajsdioasdjáiosdjaios aisdj aisdjai sdaisdjaisdj aa sdia sidjaiosdj asidj asdjaisd aisdj")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableProgramming.dataSource = self
        /*
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0.8
        blurView.frame = background.bounds
        background.addSubview(blurView)*/
 
        
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
        
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showSinopse))
        cell.addGestureRecognizer(longPress)
        
        return cell
    }

    
  
    
    @objc func showSinopse(recognizer: UILongPressGestureRecognizer){
        if recognizer.state == UIGestureRecognizer.State.began{
            let cell:UITableViewCell = recognizer.view as! UITableViewCell
           
            if let indexPath = tableProgramming.indexPath(for: cell){
                let row = indexPath.row
                let programa = lista[row]
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "modalDetail") as! ModalDetailViewController
                controller.programa = programa
             
                self.navigationController?.pushViewController(controller, animated: true)
            
                
            }
            
            
            
        }
    }
    
}
