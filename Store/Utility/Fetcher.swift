//
//  Fetcher.swift
//  Products
//
//  Created by Brian Doyle on 2/27/22.
//

import Foundation
import System

struct FetchError: Error {
    let code: Int

    var isCancelled: Bool { return code == NSURLErrorCancelled }
}

typealias FetchResult<T> = Result<T, Error>
typealias FetchCompletion<T> = (FetchResult<T>) -> Void

struct Fetcher {
    static func fetch(_ string: String, completion: @escaping FetchCompletion<Data>) {
        guard let url = URL(string: string) else {
            DispatchQueue.main.async {
                completion(.failure(FetchError(code: NSURLErrorCancelled)))
            }
            return
        }

        fetch(url, completion: completion)
    }

    static func fetch<T: Decodable>(_ string: String, into decodable: T.Type, completion: @escaping FetchCompletion<T>) {
        guard let url = URL(string: string) else {
            DispatchQueue.main.async {
                completion(.failure(FetchError(code: NSURLErrorCancelled)))
            }
            return
        }

        fetch(url, into: decodable, completion: completion)
    }

    static func fetch(_ url: URL, completion: @escaping FetchCompletion<Data>) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            let result: FetchResult<Data>

            if let error = error {
                result = .failure(error)
            } else if let data = data {
                result = .success(data)
            } else {
                result = .failure(Errno.noData)
            }

            completion(result)
        }
        task.resume()
    }

    static func fetch<T: Decodable>(_ url: URL, into decodable: T.Type, completion: @escaping FetchCompletion<T>) {
        fetch(url) { r in
            let result: FetchResult<T>

            switch r {
            case .failure(let error):
                result = .failure(error)
            case .success(let data):
                do {
                    let object = try JSONDecoder().decode(decodable, from: data)
                    result = .success(object)
                } catch {
                    print("error \(error) decoding json from \(url)")
                    result = .failure(error)
                }
            }

            completion(result)
        }
    }
}
