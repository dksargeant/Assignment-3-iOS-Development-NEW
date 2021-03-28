//
//  ResultViewController.swift
//  Assignment2
//
//  Created by user193689 on 2/19/21.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //@IBOutlet weak var coffeePicker: UIPickerView!
    var orders: [Order] = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orders")! as UITableViewCell
        cell.textLabel!.text = self.orders[indexPath.row].name + self.orders[indexPath.row].size + self.orders[indexPath.row].quantity
        return cell;
    }
}
