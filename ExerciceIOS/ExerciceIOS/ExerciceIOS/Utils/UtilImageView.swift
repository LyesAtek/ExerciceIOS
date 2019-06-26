//
//  UtilImageView.swift
//  ExerciceIOS
//
//  Created by Lyes ATEK on 26/06/2019.
//  Copyright © 2019 Lyes ATEK. All rights reserved.
//

import UIKit
extension UIImageView {
    func dowloadFromServer(imageView : UIImageView,url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            
                else { return }
            DispatchQueue.main.async() {
                imageView.image = image
            }
            }.resume()
    }
    func dowloadFromServer(imageView : UIImageView = UIImageView(), link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        dowloadFromServer(imageView: imageView,url: url, contentMode: mode)
    }
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
