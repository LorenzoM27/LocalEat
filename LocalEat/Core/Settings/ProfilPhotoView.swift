//
//  ProfilPhotoView.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 21/05/2024.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseFirestore

struct ProfilPhotoView: View {
    
    @State private var profilImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var retrieveProfilPhoto = [UIImage]() // can be UIImage? type
    
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        
        if let user = viewModel.currentUser {
            PhotosPicker(selection: $photosPickerItem, matching: .images) {
                ZStack(alignment: .bottomTrailing) {
                    if !retrieveProfilPhoto.isEmpty {
                        
                       ForEach(retrieveProfilPhoto, id: \.self) { image in // If not an array, do an if let loop
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 72, height: 72)
                                .clipShape(Circle())
                        }
                          
                        
                    } else {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                    }
                    
                    
                    Circle()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(.black)
                        .opacity(0.8)
                        .overlay {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 15, height: 15)
                                .foregroundStyle(.white)
                        }
                    
                }
                .onChange(of: photosPickerItem) { _, _ in
                    Task {
                        // if photos picker != nil
                        if let photosPickerItem,
                           // data of photosPicketItem
                           let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                            // On crée une image à partir de ces données
                            if let image = UIImage(data: data) {
                                profilImage = image
                            }
                        }
                        uploadPhoto()
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    retrievePhoto()
                }
            }
        }
    }
    
    func uploadPhoto() {
        // make sure profilImage isn't nil
        guard profilImage != nil else { return }
        
        // Create storage reference
        let storageRef = Storage.storage().reference()
        // Turn our image into data
        let imageData = profilImage!.jpegData(compressionQuality: 0.8)
        // Check that we were able to convert it to data
        guard imageData != nil else { return }
        
        // Specify the file path and name
        let path = "userImages/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        // Upload that data
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            // Check for error
            if error == nil && metadata != nil {
                // TODO: Save a reference to the file in firestore DB
                let db = Firestore.firestore()
                // will replace only fields into mergeFields by the selected image
                db.collection("users").document(viewModel.currentUser!.id).setData(["image" : path], mergeFields: ["image"]) { error in
                    
                    if error == nil {
                        DispatchQueue.main.async {
                            retrievePhoto()
                        }
                        
                    }
                }
                
            }
        }
    }
    
    func retrievePhoto() {
        // Get data from database
        let db = Firestore.firestore()
        
        db.collection("users").document(viewModel.currentUser!.id).getDocument { snapshot, error in
            
            if error == nil && snapshot != nil {
                
                var imagePaths = [String]() // : String
                // Extract file path and add to array
                let dataDescription  = snapshot!.data()
                imagePaths.append(dataDescription?["image"] as! String) // retire .append(...)
                
                // Loop through each file path and and fetch the data from storage
                for path in imagePaths {  // -> Si imagePath : String, on retire la boucle
                    
                    // Get a reference to storage
                    let storageRef = Storage.storage().reference()
                    
                    // specify the path
                    let fileRef = storageRef.child(path) //  imagePath si pas de tableau donc pas de boucle
                    
                    // retrieve the data
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        
                        // Check for errors
                        if error  == nil && data != nil {
                            
                            // create UIimage and put it into array for display
                            if let image = UIImage(data: data!) {
                                DispatchQueue.main.async {
                                    retrieveProfilPhoto.append(image) // retire .append()
                                }
                            }
                        }
                    }
               }
                
            } else {
                print("DEBUG: Impossible to fetch image from db, \(error!.localizedDescription)")
            }
        }
    }
}

//#Preview {
//    ProfilPhotoView( )
//}
