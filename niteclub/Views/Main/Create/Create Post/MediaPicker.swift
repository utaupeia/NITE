//
//  MediaPicker.swift
//  niteclub
//
//  Created by +++ on 1/30/24.
//

import Foundation
import UIKit
import SwiftUI

struct MediaPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var selectedVideoURL: URL?
    var sourceType: UIImagePickerController.SourceType = .photoLibrary // default source type

    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = context.coordinator

        // Specify media types
        picker.mediaTypes = ["public.image", "public.movie"]
        picker.sourceType = sourceType

        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: MediaPicker

        init(parent: MediaPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
            } else if let selectedVideoURL = info[.mediaURL] as? URL {
                parent.selectedVideoURL = selectedVideoURL
            }
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}
