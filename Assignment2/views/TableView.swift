//
//  TableView.swift
//  Assignment2
//
//  Created by Rocco Alexander on 2/19/21.
//  033315151


import UIKit

class TableView: UITableViewController {
    
    var orders:[Orders] = [Orders]()
    private let dbHelper = DatabaseHelper.getInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchAllOrders()
        // Uncomment the following line to preserve selection between presentations        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orders", for: indexPath) as! CellView
        if(indexPath.row < orders.count){
            cell.nameLabel.text = orders[indexPath.row].name
            cell.sizeLabel.text = orders[indexPath.row].quantity
            cell.quantityLabel.text = orders[indexPath.row].size
        }
        return cell
    }
   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
//    Select Between Updating or Deleing Data
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.orders.count{
            let alert = UIAlertController(title: "Selected Order", message: "What would you like to do with your order?", preferredStyle: .alert)
            alert.addTextField{(textField: UITextField)in textField.placeholder = "Enter new amount"
            }
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: {action in
                let titleText = alert.textFields?[0].text
                self.updateOrder(quantity: titleText!, indexPath: indexPath)
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
                self.deleteOrder(indexPath: indexPath)
            }))
            present(alert, animated: true, completion: nil)
        }
    }

//    Get all Orders
    private func fetchAllOrders(){
        if(self.dbHelper.getAllOrders() != nil){
            self.orders = self.dbHelper.getAllOrders()!
            self.tableView.reloadData()
        }
        else{
            print("No data to pull")
        }
    }
    
//    Delete Order
    private func deleteOrder(indexPath:IndexPath){
        self.dbHelper.deleteOrder(orderID: self.orders[indexPath.row].id!)
        self.fetchAllOrders()
    }
    
//    Update Order
    private func updateOrder(quantity:String, indexPath: IndexPath){
        self.dbHelper.updateOrder(quantity: quantity, orderID: self.orders[indexPath.row].id!)
        self.fetchAllOrders()
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
