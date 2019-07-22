//
//  ProgrammingViewController.swift
//  BFF-Muchmore
//
//  Created by Haziel Leite Farias on 17/07/19.
//  Copyright © 2019 Haziel. All rights reserved.
//

import UIKit

class ProgrammingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
   
    @IBOutlet weak var programTitleTop: UILabel!
    @IBOutlet weak var tableProgramming: UITableView!
    @IBOutlet weak var background: UIImageView!
    
   
    var timer = Timer()
    
    var flag = false
    
    let lista:Array<ProgramData> = [ProgramData(title: "Programa diário", detail: "Começa as 8h termina as 20h", imageAdress: "imagem-programa.png", sinopse: "uni duni tê salame mingue"), ProgramData(title: "Programa da madruga com nome grande", detail: "Começa as 20h termina as 8h", imageAdress: "capa-teste.jpg", sinopse: "uni duni tê salame mingue oajsdiasdijaisd asjdiadjsia iajsdiajds ajsdiasd aisdj iasdjiasdj iajsdioasdjáiosdjaios aisdj aisdjai sdaisdjaisdj aa sdia sidjaiosdj asidj asdjaisd aisdj")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableProgramming.dataSource = self
        self.tableProgramming.delegate = self
        self.loadPage()
        if flag == false{
            self.flag = true
            self.atualizar()
        }
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
        
        var image = msgStringFull[4].components(separatedBy: ":")
        image.remove(at: 0)
        image[0]=image[0]+":"
        let imageUrl = image.joined().replacingOccurrences(of: " ", with: "")
        let url2 = URL(string: imageUrl)
    
        if let data = try? Data(contentsOf: url2!){ 
            background.image = UIImage(data: data)
            
        }
      
    }
   
    
    func atualizar(){
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(loadPage), userInfo: nil, repeats: true)
        
    }
}
