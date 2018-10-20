//
//  TaskManager.swift
//  weather
//
//  Created by Liu bo on 16/10/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import Foundation

class TaskManager {
    static let shared = TaskManager()
    
    let session = URLSession(configuration: .default)
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var tasks = [URL: [completionHandler]]()
    
    func dataTask(with url: URL, completion: @escaping completionHandler) {
        if tasks.keys.contains(url) {
            tasks[url]?.append(completion)
        } else {
            tasks[url] = [completion]
            let _ = session.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                DispatchQueue.main.async {
                    guard let completionHandlers = self?.tasks[url] else { return }
                    
                    for handler in completionHandlers {
                        
                        handler(data, response, error)
                    }
                }
            }).resume()
        }
    }
}
