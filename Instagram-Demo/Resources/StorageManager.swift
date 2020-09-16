//
//  StorageManager.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 28/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    private let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error {
        
        case failedToDownload
    }
    
    // MARK: - Public
    public func uploadUserPost(model: UserPost, complition: @escaping (Result<URL, Error>) -> Void) {
        
        
    }
    
    public func downloadImage(with reference: String, complition: @escaping (Result<URL, IGStorageManagerError>) -> Void) {
        
        bucket.child(reference).downloadURL(completion: { url, error in
            
            guard let url = url, error == nil else {
                
                complition(.failure(.failedToDownload))
                return
            }
            complition(.success(url))
        })
    }
}
