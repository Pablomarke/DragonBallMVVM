//
//  UIimage+remote.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import UIKit

// MARK: - Extension -
extension UIImageView {
    func setImage(for url: URL) {
        downloadImage(url: url) { [weak self] result in
            guard case let .success(image) = result else {
                return
            }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }

// MARK: - Función para obtener imagenes desde URL -
    private func downloadImage(
        url: URL,
        completion: @escaping (
            Result<UIImage,
            Error>
        ) -> Void
    ) {
        let task = URLSession.shared.dataTask(with: url) {  data, response, _ in
            let result: Result<UIImage, Error>
            defer {
                completion(result)
            }
            guard let data, let image = UIImage(data: data) else {
                result = .failure(NSError(domain: "No image", code: -1))
                return
            }
            result = .success(image)
        }
        task.resume()
    }
}
