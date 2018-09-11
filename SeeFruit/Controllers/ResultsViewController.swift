//
//  ResultsViewController.swift
//  SeeFruit
//
//  Created by Zain Budhwani on 9/9/18.
//  Copyright © 2018 Zain Budhwani. All rights reserved.
//

import UIKit
import Vision

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var photoTakenImageView: UIImageView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var fruitLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var cameraPhotoImage = UIImage()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoTakenImageView.image = cameraPhotoImage
        activityIndicator.startAnimating()
        classifyImage()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func classifyImage() {
        // Load the model
        guard let model = try? VNCoreMLModel(for: fruit_classifier().model) else {
            print("Error loading model")
            DispatchQueue.main.async {
                self.dealWithError()
            }
            return
        }
        
        // Create vision request
        let request = VNCoreMLRequest(model: model) { (finishedReq, error) in
            if(error != nil) {
                print(error?.localizedDescription as Any)
                DispatchQueue.main.async {
                    self.dealWithError()
                }
            }
            guard let results = finishedReq.results as? [VNClassificationObservation] else {
                print("Error loading results")
                DispatchQueue.main.async {
                    self.dealWithError()
                }
                return
            }
            guard let topResult = results.first else{
                print("No results")
                DispatchQueue.main.async {
                    self.dealWithError()
                }
                return
            }
            
            // Update results
            DispatchQueue.main.async {
                self.resultView.backgroundColor = UIColor.green
                self.fruitLabel.text = "\(topResult.identifier)"
                self.activityIndicator.stopAnimating()
            }
        }
        
        // Run the classifier
        let handler = VNImageRequestHandler(cgImage: cameraPhotoImage.cgImage!)
        DispatchQueue.global().async {
            do {
                try handler.perform([request])
            } catch {
                print(error.localizedDescription as Any)
            }
        }
    }
    
    func dealWithError() {
        resultView.backgroundColor = UIColor.red
        fruitLabel.text = "Could not find match"
        activityIndicator.stopAnimating()
    }
}
