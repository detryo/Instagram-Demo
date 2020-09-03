//
//  DatabaseManager.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 28/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    // MARK: - Public
    
        // Check if user name is available
      /// - Parameters
      /// - email String representing email
      /// - userName String representing user name
    public func canCreateNewUser(with email: String, userName: String, complition: (Bool) -> Void) {
        // provisional
        complition(true)
    }
    
        // Insert new user data to Database
       /// - Parameters
       /// - email String representing email
       /// - userName String representing user name
       /// - completion Async callback  for result if database entry succeded
    public func insertNewUser(with email: String, userName: String, completion: @escaping (Bool) -> Void) {
        
        database.child(email.safeDatabaseKey()).setValue(["userName": userName]) { error, _ in
            if error == nil {
                // succeded
                completion(true)
                return
            } else {
                // failed
                completion(false)
                return
            }
        }
    }
}
