//
//  GalleryViewController.swift
//  BatApp
//
//  Created by Gemma Yebra i Berenguer on 3/12/24.
//

import UIKit
import Photos

class GalleryViewController: UIViewController {

    var images: [UIImage] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self

        
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("gallery", comment: "")
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImage))
        self.navigationItem.rightBarButtonItem = plusButton
        
        images = loadImagesFromDocuments()
        collectionView.reloadData()
    }
    
    @objc func addImage() {
        // TODO: Fer el segue
        print("ADD IMAGE")
        
        // Show gallery
        requestAccessToPhotos()
    }
    
    
    private func initializeCustomCell(){
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "imageCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initializeCustomCell()
        
        print("Number of images: \(images.count)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func presentImagePicker(_ type: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true // Enable editing
        picker.sourceType = type
        self.present(picker, animated: true)
    }
    
    private func requestAccessToPhotos() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                print("Access granted")
                DispatchQueue.main.async{
                    self.presentImagePicker(.photoLibrary)
                }
            case .denied, .restricted:
                print("Access denied")
            case .notDetermined:
                print("Access not determined")
            case .limited:
                print("Access limited")
            @unknown default: break
            }
        }
    }
    
    private func requestAccessToCamera(){
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                DispatchQueue.main.async{
                    self.presentImagePicker(.camera)
                }
            } else {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }
        }
    }
    
    @IBAction func cameraButtonTouched(_ sender: Any) {
        requestAccessToCamera()
    }
    
    
    func loadImagesFromDocuments() -> [UIImage] {
        var images: [UIImage] = []
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            for fileURL in fileURLs where fileURL.pathExtension == "jpg" || fileURL.pathExtension == "png" {
                if let image = UIImage(contentsOfFile: fileURL.path) {
                    images.append(image)
                }
            }
        } catch {
            print("Error al cargar las imágenes: \(error)")
        }
        
        return images
    }

    
}



extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        // Usa la imagen recortada si está disponible, de lo contrario usa la original
        let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
        
        if let image = image {
            saveImageToDocuments(image: image)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    private func saveImageToDocuments(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return } // Cambia a `pngData()` si prefieres PNG
        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = UUID().uuidString + ".jpg" // Genera un nombre único para la imagen
        let fileURL = documentsURL.appendingPathComponent(fileName)

        do {
            try data.write(to: fileURL)
            print("Imagen guardada en: \(fileURL.path)")
            
            // Add image to the image array and reload data
            if let savedImage = UIImage(contentsOfFile: fileURL.path) {
                images.append(savedImage) // Add image to the array
                collectionView.reloadData() // Reload CollectionView
            }
        } catch {
            print("Error al guardar la imagen: \(error)")
        }
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        let image = images[indexPath.row]
        cell.customImage.image = image
        
        print("image: \(image)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
       }
}


extension GalleryViewController: UICollectionViewDelegate {
    
}
