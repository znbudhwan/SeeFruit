//
//  ViewController.swift
//  SeeFruit
//
//  Created by Zain Budhwani on 9/4/18.
//  Copyright © 2018 Zain Budhwani. All rights reserved.
//

import UIKit
import AVKit
import CoreML

class ClassifierViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var seeFruitLabel: UILabel!
    @IBOutlet weak var touchLabel: UILabel!
    var cameraImage: UIImage?
    var cameraPhotoController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let strokeTextAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -4.5,
        ]
        
        seeFruitLabel.attributedText = NSAttributedString(string: "SEEFRUIT", attributes: strokeTextAttributes)
        touchLabel.attributedText = NSAttributedString(string: "Touch to SEEFRUIT", attributes: strokeTextAttributes)
    }
    
    @IBAction func takeAPicture(_ sender: Any) {
        cameraPhotoController.sourceType = .camera
        cameraPhotoController.delegate = self
        present(cameraPhotoController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let photoTakenImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("No Image")
            return
        }
        cameraImage = photoTakenImage
        performSegue(withIdentifier: "showResults", sender: self)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults" {
            let navController = segue.destination
            let rootViewController = navController.childViewControllers.first as? ResultsViewController
            rootViewController?.cameraPhotoImage = cameraImage!
        }
    }
    
}
