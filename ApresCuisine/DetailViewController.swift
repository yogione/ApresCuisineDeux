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
import MapKit

class DetailViewController: UIViewController, CameraManagerDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate,  MKMapViewDelegate {
    
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
            cameraMgr.save(image: image)
        } else {
            print("no image")
        }
    }
    
    let cameraMgr = CameraManager()
    
    //MARK: - Built-In Camera Methods
    
   /* @IBAction func galleryPressed(button: UIButton) {
        print("Gallery")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
        
    } */
    
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
        let imageFileName = dishNameTextField.text! + ".png"
        let dish = DishItem(dishname: dishNameTextField.text!, rating: Int(ratingTextField.text!)!, review: reviewTextField.text!, imageFileName: imageFileName, lat: "0", long: "0")
        save(dish: dish)
    }
    
    @IBAction func updateToDo(button: UIButton){
        guard let dish = selectedDish else {
            return
        }
        dish.dishName = dishNameTextField.text!
        dish.rating = Int(ratingTextField.text!)!
        dish.reviewText = reviewTextField.text!
        dish.imageFileName = dishNameTextField.text! + ".png"
        dish.lat = "0"
        dish.long = "0"
        
        save(dish: dish)
        
    }
    @IBAction func save(dish: DishItem){
        dish.saveInBackground { (success, error) in
            print("obj saved")
           // self.fetchToDos()
        }
    }
    @IBOutlet var coffeeMap       :MKMapView!
    
    @IBAction func longPressed(gesture: UILongPressGestureRecognizer){
        if gesture.state == .ended {
            print("Long Press")
            let point = gesture.location(in: coffeeMap)
            let coord = coffeeMap.convert(point, toCoordinateFrom: coffeeMap)
      //      let loc = Location(name: "Long Press \(coord.latitude), \(coord.longitude)",
         //       address: "n/a", lat: coord.latitude, lon: coord.longitude )
        //    coffeeArray.append(loc)
            ////  annotateMapLocations()
            
       //     let index = coffeeArray.index(of: loc)!
        //    coffeeMap.addAnnotation(pinFor(loc: loc, index: index))
            let circle = MKCircle(center: coord, radius: 1000)
            coffeeMap.add(circle, level: .aboveRoads)
            
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
    
    
    //mark - map view delegate methods
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let renderer = MKCircleRenderer(overlay: overlay)
            renderer.fillColor = .green
            renderer.alpha = 0.5
            return renderer
            
        }
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKUserLocation){
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin") as? MKPinAnnotationView
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation:annotation, reuseIdentifier: "Pin")
            }
            pinView!.annotation = annotation
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinTintColor = .orange
            let pinButton = UIButton(type: .detailDisclosure)
            pinView!.rightCalloutAccessoryView = pinButton
            return pinView
            
        }
        return nil
    }
}
