//
//  LandingScreenViewController.swift
//  Online-Medical-App
//
//  Created by Srinath Gopal on 14/10/22.
//

import UIKit

class LandingScreenViewController: UIViewController {

    let mainStoryboard : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    @IBOutlet weak var transactionHistoryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(0, forKey: "orderHistory")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.transactionHistoryLabel.text = String(UserDefaults.standard.object(forKey: "orderHistory") as! Int)
    }
    
    @IBAction func onClickBookDoctorAppointment(_ sender: Any) {
        let bookDoctorAppointmentVC : BookDoctorAppointmentViewController = mainStoryboard.instantiateViewController(withIdentifier: "BookDoctorAppointmentViewController") as! BookDoctorAppointmentViewController
        self.navigationController?.pushViewController(bookDoctorAppointmentVC, animated: true)
    }
    
    @IBAction func onClickBookLabAppointment(_ sender: Any) {
        let bookLabAppointment : BookDoctorAppointmentViewController = mainStoryboard.instantiateViewController(withIdentifier: "BookDoctorAppointmentViewController") as! BookDoctorAppointmentViewController
        self.navigationController?.pushViewController(bookLabAppointment, animated: true)
    }
    
    
    @IBAction func onClickOrderMedicine(_ sender: Any) {
        let orderMedicineVC : OrderMedicineViewController = mainStoryboard.instantiateViewController(withIdentifier: "OrderMedicineViewController") as! OrderMedicineViewController
        self.navigationController?.pushViewController(orderMedicineVC, animated: true)
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
