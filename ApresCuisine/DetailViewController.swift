//
//  DetailViewController.swift
//  ApresCuisine
//
//  Created by Srini Motheram on 2/27/17.
//  Copyright © 2017 Srini Motheram. All rights reserved.
//

import UIKit
import Parse
import Social
import AVFoundation

class DetailViewController: UIViewController, CameraManagerDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var dishNameTextField    :UITextField!
    @IBOutlet var ratingTextField     :UITextField!
    @IBOutlet var reviewTextField       :UITextField!
    
    let avMgr = AVManager.sharedInstance
    
    //MARK: - Custom Camera Methods
    
    @IBOutlet var previewView: UIView!    
    
    func camera(didSet previewLayer: AVCaptureVideoPreviewLayer) {
        previewView.layer.addSublayer(previewLayer)
    }
    
    func cameraBoundsForPreviewView() -> CGRect {
        return previewView.bounds
    }
    
    @IBAction func takePhotoPressed(button: UIButton) {
        cameraMgr.takePhoto()
    }
    
    func camera(didCapture image: UIImage) {
        capturedImage.image = image
    }
    
    //MARK: - Save File Methods
    
    @IBOutlet private weak var capturedImage :UIImageView!
    
    @IBAction func savePressed(button: UIButton) {
        if let image = capturedImage.image {
            cameraMgr.save2(image: image, filename: "curry.png")
        } else {
            print("no image")
        }
    }
    
    let cameraMgr = CameraManager()
    
    //MARK: - Built-In Camera Methods
    
    @IBAction func galleryPressed(button: UIButton) {
        print("Gallery")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func builtinCameraPressed(button :UIButton) {
        print("Camera")
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
            
        } else {
            print("no camera")
        }
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        capturedImage.image = (info[UIImagePickerControllerOriginalImage] as! UIImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
     var selectedDish    :DishItem?
    
    //MARK: PARSE METHODS
    @IBAction func addToDo(button: UIButton){
        let dish = DishItem(dishname: dishNameTextField.text!, rating: Int(ratingTextField.text!)!, review: reviewTextField.text!, imageFileName: "curry.png", lat: "0", long: "0")
        save(dish: dish)
    }
    
    @IBAction func updateToDo(button: UIButton){
        guard let dish = selectedDish else {
            return
        }
        dish.dishName = dishNameTextField.text!
        dish.rating = Int(ratingTextField.text!)!
        dish.reviewText = reviewTextField.text!
        
        save(dish: dish)
        
    }
    @IBAction func save(dish: DishItem){
        dish.saveInBackground { (success, error) in
            print("obj saved")
           // self.fetchToDos()
        }
    }
    
    @IBAction func shareOnWhatever(button: UIButton){
        let shareString = "I love \(selectedDish?.dishName)"
        let activityVC = UIActivityViewController(activityItems: [shareString],
                                                  applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
