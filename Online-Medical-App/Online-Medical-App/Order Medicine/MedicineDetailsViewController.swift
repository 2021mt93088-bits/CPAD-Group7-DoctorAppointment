//
//  MedicineDetailsViewController.swift
//  Online-Medical-App
//
//  Created by Srinath Gopal on 18/10/22.
//

import UIKit

class MedicineDetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let mainStoryboard : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    @IBOutlet weak var stepper: UIStepper!
    var selectedMedicine : String = ""
    var count : Int = 0
    
    @IBOutlet weak var medicineCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedMedicine = UserDefaults.standard.object(forKey: "selectedMedicine") as! String
        self.medicineNameLabel.text = selectedMedicine
    }
    @IBOutlet weak var medicineNameLabel: UILabel!
    
    @IBAction func onClickAddtoCart(_ sender: Any) {
        UserDefaults.standard.set(medicineCountLabel.text, forKey: "medicineCount")
        self.showToast(message: "added to cart", font: UIFont.systemFont(ofSize: 20))
    }
    
    @IBAction func onClickViewCart(_ sender: Any) {
        let viewCartVC : ViewCartViewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewCartViewController") as! ViewCartViewController
        self.navigationController?.pushViewController(viewCartVC, animated: true)
    }
    
    @IBOutlet weak var prescriptionImageView: UIImageView!
    
    @IBAction func onClickSelectPhoto(_ sender: Any) {
        self.showImagePicker(selectSource: .photoLibrary)
    }
    
    func showImagePicker(selectSource: UIImagePickerController.SourceType){
        guard UIImagePickerController.isSourceTypeAvailable(selectSource) else {
            print("s")
            return
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = selectSource
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let s = info[.originalImage] as? UIImage {
            self.prescriptionImageView.image = s
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickStepper(_ sender: UIStepper) {
        medicineCountLabel.text = String(Int(sender.value))
    }
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 95, y: self.view.frame.size.height-100, width: 150, height: 35))
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
