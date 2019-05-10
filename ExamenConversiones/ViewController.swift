//
//  ViewController.swift
//  ExamenConversiones
//
//  Created by Jose Luis Cristobal on 10/05/19.
//  Copyright © 2019 Jose Luis Cristobal. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var conversiones:[Conversion] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        obtenerConversiones()
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let conversion = conversiones[indexPath.row]
        if editingStyle == .delete {
            print("Delete")
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(conversion)
            conversiones.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversiones.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let conversion = conversiones[indexPath.row]
        cell.textLabel?.text = "\(conversion.medidaInicial) \(conversion.unidadInicial!) SON : \(conversion.medidaFinal) \(conversion.unidadFinal!)"
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func obtenerConversiones(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            conversiones = try context.fetch(Conversion.fetchRequest()) as! [Conversion]
        } catch {
            print("Ha ocurrido un error")
        }
    }

    @IBAction func agregarConversion(_ sender: Any) {
        performSegue(withIdentifier: "agregarSegue", sender: nil)
    }
}

