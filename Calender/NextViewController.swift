//
//  NextViewController.swift
//  Calender
//
//  Created by 村上航輔 on 2020/01/29.
//  Copyright © 2020 kyamisuke. All rights reserved.
//

import UIKit

class NextViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var topBar: UIView!
    var selectDay: (Int, Int, Int)!
    var stringSelectDay: String!
    
    var saveData: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        stringSelectDay = String(selectDay.0)
        stringSelectDay += String(selectDay.1)
        stringSelectDay += String(selectDay.2)
        if saveData.object(forKey: stringSelectDay + "title") != nil {
            textField.text = saveData.object(forKey: stringSelectDay + "title") as? String
        }
        if saveData.object(forKey: stringSelectDay + "image") != nil {
            let pickedData = saveData.object(forKey: stringSelectDay + "image")
            selectedImage.image = UIImage(data: pickedData as! Data)
        }
        
        textField.delegate = self
        self.topBar.layer.cornerRadius = 5
    }
    
    
    @IBAction func selectImage(_ sender: Any) {
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        
        selectedImage.image = image
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        let data = selectedImage.image?.pngData()
        saveData.set(textField.text, forKey: stringSelectDay + "title")
        saveData.set(data, forKey: stringSelectDay + "image")
        
        let alert: UIAlertController = UIAlertController(title: "保存", message: "保存が完了しました", preferredStyle: .alert)

        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: {  action in
                    self.dismiss(animated: true, completion: nil)
                }
            )
        )
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
