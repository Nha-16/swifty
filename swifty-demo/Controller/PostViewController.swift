//
//  PostViewController.swift
//  swifty-demo
//
//  Created by Mavin on 10/11/21.
//

import UIKit
import ProgressHUD

class PostViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var articleImageView: UIImageView!
    
    //1
    var pickerView = UIImagePickerController()
    let alertCon = UIAlertController(title: "Choose Options", message: nil, preferredStyle: .actionSheet)
    
    var imageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2 Set up Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showOptions))
        
        self.articleImageView.isUserInteractionEnabled = true
        self.articleImageView.addGestureRecognizer(tapGesture)
        pickerView.delegate = self
        prepareOptions()

    }
    
    func chooseOptions(option: UIImagePickerController.SourceType){
        self.pickerView.allowsEditing = true
        self.pickerView.mediaTypes = ["public.image"]
        self.pickerView.sourceType = option
        
        present(self.pickerView, animated: true, completion: nil)
      
    }
    
    func prepareOptions(){
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.chooseOptions(option: .camera)
        }
        let gallary = UIAlertAction(title: "Gallary", style: .default) { _ in
            self.chooseOptions(option: .photoLibrary)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertCon.addAction(camera)
        alertCon.addAction(gallary)
        alertCon.addAction(cancel)
    }
    
    @objc func showOptions(){
        present(alertCon, animated: true, completion: nil)
    }
    
    @IBAction func postPressed(_ sender: Any) {
        
        let title = titleTextView.text
        let description = descriptionTextView.text
        
        ProgressHUD.show()
        
        Network.shared.uploadImage(imageData: imageData) { url in
            
            Network.shared.postArticle(title: title, description: description, imageURL: url) { result in
                switch result {
                case .success(let msg):
                    ProgressHUD.showSucceed(msg)
                case .failure(let error):
                    ProgressHUD.showError(error.localizedDescription)
                }
            }
        }
        
    }


}
extension PostViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
        if let possibleImage = info[.editedImage] as? UIImage {
            self.articleImageView.image = possibleImage

            self.imageData = possibleImage.jpegData(compressionQuality: 1.0)
            
        }
        
        dismiss(animated: true)
    }
}
