//
//  ViewController.swift
//  Assignment2
//
//  Created by Rocco Alexander on 2/19/21.
//  033315151


import UIKit
class ViewController: UIViewController, UIPickerViewDelegate {
    
    private let dbHelper = DatabaseHelper.getInstance()

    
    
//    Setting up the storyboard elements
    @IBOutlet weak var coffeeTypePicker: UIPickerView!
    @IBOutlet weak var coffeeSizePicker: UIPickerView!
    @IBOutlet weak var quantityText: UITextField!
    @IBOutlet weak var addOrderButton: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var checkoutButton: UINavigationItem!
    
    
  
    //    Setting up picker view Data
    var coffeePickerData:[String] = [String]()
    var coffeeSizePickerData:[String] = [String]()
    var orders:[Order] = [Order]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//    Connect Data
        self.coffeeTypePicker.delegate = self
        self.coffeeSizePicker.delegate = self
        
        coffeePickerData = ["Light Roast", "Dark Roast", "Medium Roast", "French Roast", "City Roast"]
        coffeeSizePickerData = ["Small", "Medium", "Large", "Extra Large"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
//    Insert new order to database
    @IBAction func addButton(_ sender: Any) {
        let newOrder = Order()
        if(!self.quantityText.text!.isEmpty){
            newOrder.name = String(coffeePickerData[coffeeTypePicker.selectedRow(inComponent: 0)])
            newOrder.size = String(coffeeSizePickerData[coffeeSizePicker.selectedRow(inComponent: 0)])
            newOrder.quantity = quantityText.text!
            
            self.dbHelper.insertOrder(new: newOrder)
        }
    }
    
    
    @IBAction func done(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let orderView = storyboard.instantiateViewController(identifier: "OrderView")
        performSegue(withIdentifier: "segue", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! TableView
//        vc.orders = self.orders
//        navigationController?.pushViewController(vc,animated: true)
//    }
}

extension ViewController: UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return coffeePickerData.count
        }
        else{
            return coffeeSizePickerData.count;
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent
        component: Int) -> String? {
        if pickerView.tag == 1{
            return coffeePickerData[row]
        }
        else{
            return coffeeSizePickerData[row]
        }
    }
}
