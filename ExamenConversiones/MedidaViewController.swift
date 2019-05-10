//
//  MedidaViewController.swift
//  ExamenConversiones
//
//  Created by Jose Luis Cristobal on 10/05/19.
//  Copyright © 2019 Jose Luis Cristobal. All rights reserved.
//

import UIKit

class MedidaViewController: UIViewController {


    @IBOutlet weak var txtMedidaInicial: UITextField!
    
    @IBOutlet weak var txtUnidadInicial: UITextField!
    
    @IBOutlet weak var txtUnidadFinal: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func convertir(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let conversion = Conversion(context: context)
        
        conversion.unidadInicial = txtUnidadInicial.text!.lowercased()
        conversion.medidaInicial = Float(txtMedidaInicial.text!)!
        conversion.unidadFinal = txtUnidadFinal.text!.lowercased()
        
        if (conversion.unidadInicial == "kilometros" || conversion.unidadInicial == "kilómetros") && conversion.unidadFinal == "millas"{
            conversion.medidaFinal = Float(conversion.medidaInicial / 1.609)
        }
        if (conversion.unidadInicial == "kilometros" || conversion.unidadInicial == "kilómetros") && conversion.unidadFinal == "yardas"{
            conversion.medidaFinal = Float(conversion.medidaInicial * 1093.613)
        }
        if conversion.unidadInicial == "millas" && (conversion.unidadFinal == "kilometros" || conversion.unidadFinal == "kilómetros"){
            conversion.medidaFinal = Float(conversion.medidaInicial * 1.609)
        }
        if conversion.unidadInicial == "millas" && conversion.unidadFinal == "yardas"{
            conversion.medidaFinal = Float(conversion.medidaInicial * 1760)
        }
        if conversion.unidadInicial == "yardas" && (conversion.unidadFinal == "kilometros" || conversion.unidadFinal == "kilómetros"){
            conversion.medidaFinal = Float(conversion.medidaInicial / 1093.613)
        }
        if conversion.unidadInicial == "yardas" && conversion.unidadFinal == "millas"{
            conversion.medidaFinal = Float(conversion.medidaInicial / 1760)
        }
        navigationController!.popViewController(animated: true)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
}
