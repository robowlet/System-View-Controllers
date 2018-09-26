//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Rob Miguel on 4/30/18.
//  Copyright © 2018 Rob Miguel. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func shareTapped(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [image, "This is a tree. That's all."], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = sender
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func safariTapped(_ sender: UIButton) {
        guard let url = URL(string: "http://www.apple.com") else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        
        present(safariViewController, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: UIButton) {
        // Create image picker to use later
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        // Create alert controller
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        
        //Create and add cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        // Create and add camera action IF the camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        
        // Create and add photo library action IF the photo library is available
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(photoLibraryAction)
        }
        
        // Set the source view for the popover used on ipads
        alertController.popoverPresentationController?.sourceView = sender
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func emailTapped(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else {
            print("Can not send mail")
            return
        }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        mailComposer.setToRecipients(["robmiguel2@gmail.com"])
        mailComposer.setSubject("This is an email dude.")
        mailComposer.setMessageBody("THis really is an email.. with text and stuff", isHTML: false)
        
        present(mailComposer, animated: true, completion: nil)
        
    }
    
    @IBAction func messageTapped(_ sender: UIButton) {
        guard MFMessageComposeViewController.canSendText() else {
            print("Can't send mail")
            return
        }
        let messageComposer = MFMessageComposeViewController()
        messageComposer.messageComposeDelegate = self
        
        present(messageComposer, animated: true, completion: nil)
    }
    
}

extension ViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = selectedImage
            dismiss(animated: true, completion: nil)
        }
    }
}

