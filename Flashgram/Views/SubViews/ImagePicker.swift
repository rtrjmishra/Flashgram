//
//  ImagePicker.swift
//  Flashgram
//
//  Created by Rituraj Mishra on 04/03/23.
//

import SwiftUI
import Foundation


struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var imageSelected: UIImage
    @Binding var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePicker>) { }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(parent: self)
    }
}

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let parent: ImagePicker

    init(parent: ImagePicker) {
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            parent.imageSelected = image //selecting
            parent.presentationMode.wrappedValue.dismiss() //dismissing
        }
    }
}
