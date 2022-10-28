//
//  ViewCartViewController.swift
//  Online-Medical-App
//
//  Created by Srinath Gopal on 19/10/22.
//

import UIKit

class ViewCartViewController: UIViewController {

    @IBOutlet weak var medicineCountLabel: UILabel!
    @IBOutlet weak var medicineNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.medicineNameLabel.text = UserDefaults.standard.object(forKey: "selectedMedicine") as? String
        
        self.medicineCountLabel.text = UserDefaults.standard.object(forKey: "medicineCount") as? String
        
    }
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 145, y: self.view.frame.size.height-100, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    @IBAction func onClickOrder(_ sender: Any) {
        let s = UserDefaults.standard.object(forKey: "orderHistory") as? Int
        if s != nil {
            UserDefaults.standard.set(s! + 1, forKey: "orderHistory")
        }
        self.showToast(message: "Ordered Successfully!", font: UIFont.systemFont(ofSize: 20))
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
