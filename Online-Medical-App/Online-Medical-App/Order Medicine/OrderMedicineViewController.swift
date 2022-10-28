//
//  OrderMedicineViewController.swift
//  Online-Medical-App
//
//  Created by Srinath Gopal on 16/10/22.
//

import UIKit

class OrderMedicineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    
    var tablets: [String] = [String]()
    
    
    

                                          

    
    let mainStoryboard : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tablets.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : OrderMedicineTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OrderMedicineTableViewCell", for: indexPath) as! OrderMedicineTableViewCell
        cell.medicineLable.text = tablets[indexPath.row]
        return cell
    }
    
    
    @IBAction func onClickRefill(_ sender: Any) {
        let s = UserDefaults.standard.object(forKey: "orderHistory") as! Int
        if s > 0
        {
        let viewCartVC : ViewCartViewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewCartViewController") as! ViewCartViewController
        self.navigationController?.pushViewController(viewCartVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMedicine = tablets[indexPath.row].lowercased()
        UserDefaults.standard.set(selectedMedicine, forKey: "selectedMedicine")
        let medicineDetailVC : MedicineDetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "MedicineDetailsViewController") as! MedicineDetailsViewController
        self.navigationController?.pushViewController(medicineDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func validateSearchedMedicine(searchedMedicine : String) -> Bool {
        for i in tablets {
            if i.lowercased() == searchedMedicine.lowercased()
            {
                return true
            }
        }
        return false
    }
    
    @IBAction func onclickSearchButton(_ sender: Any) {
        let selectedMedicine = self.searchMedicineTextField.text?.lowercased()
        if selectedMedicine != nil{
            if selectedMedicine != "" {
                UserDefaults.standard.setValue(selectedMedicine, forKey: "selectedMedicine")
                let medicineDetailVC : MedicineDetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "MedicineDetailsViewController") as! MedicineDetailsViewController
                if validateSearchedMedicine(searchedMedicine : selectedMedicine!) {
                    self.navigationController?.pushViewController(medicineDetailVC, animated: true)
                } else {
                    let alert: UIAlertController = UIAlertController.init(title: "Sorry!", message: "The medicine searched is not available", preferredStyle: UIAlertController.Style.alert)
                    let ok: UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(ok)
                    self.navigationController?.present(alert, animated: true, completion: nil)
                }
                
            } else {
                let alert: UIAlertController = UIAlertController.init(title: "Sorry!", message: "Please type your medicine name to search", preferredStyle: UIAlertController.Style.alert)
                let ok: UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(ok)
                self.navigationController?.present(alert, animated: true, completion: nil)
            }
        } else {
            
        }
    }
    
    @IBOutlet weak var searchMedicineTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var orderMedicineTableView: UITableView!
    
    @IBOutlet weak var transactionHistory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchButton.layer.cornerRadius = 10
        self.orderMedicineTableView.delegate = self
        self.orderMedicineTableView.dataSource = self
        
        let url = "http://127.0.0.1:8081/medicineNames"
        
        let urlRequest: URLRequest = URLRequest.init(url: (URL(string: url) ?? URL(string: ""))!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let jsonData : Dictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, Any>
            self.tablets = (jsonData["names"] as? [String])!
            DispatchQueue.main.async {
                self.orderMedicineTableView.reloadData()
            }
        }
                   
        task.resume()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.searchMedicineTextField.text = ""
        self.transactionHistory.text = String(UserDefaults.standard.object(forKey: "orderHistory") as! Int)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
