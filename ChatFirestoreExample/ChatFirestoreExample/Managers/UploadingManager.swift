//
//  UploadingManager.swift
//  ChatFirestoreExample
//
//  Created by Alisa Mylnikova on 26.06.2023.
//

import Foundation
import FirebaseStorage

class UploadingManager {

    static func uploadMedia(_ media: Media?) async -> URL? {
        guard let data = await media?.getData() else { return nil }
        let ref = Storage.storage().reference()
            .child("\(UUID().uuidString).jpg")
        return await uploadData(data, ref)
    }

    static func uploadRecording(_ recording: Recording?) async -> URL? {
        guard let url = recording?.url, let data = try? Data(contentsOf: url) else { return nil }
        let ref = Storage.storage().reference()
            .child("\(UUID().uuidString).aac")
        return await uploadData(data, ref)
    }

    static func uploadData(_ data: Data, _ ref: StorageReference) async -> URL? {
        await withCheckedContinuation { continuation in
            ref.putData(data, metadata: nil) { metadata, error in
                guard let _ = metadata else {
                    print(error.debugDescription)
                    continuation.resume(returning: nil)
                    return
                }
                ref.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print(error.debugDescription)
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: downloadURL)
                }
            }
        }
    }
}
