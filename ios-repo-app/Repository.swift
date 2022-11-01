//
//  Repository.swift
//  ios-repo-app
//
//  Created by Brian Bansenauer on 10/5/19.
//  Copyright © 2019 Cascadia College. All rights reserved.
//
import Foundation
// TODO : Add Repo Protocol to allow for a MockAPIRepo
protocol APIRepository {
//    associatedtype Element
//    func fetch() -
//    (withId: <#T##Int#>, withCompletion: <#T##(Element?) -> Void#>){{}}
//    create()
//    update()
//    delete
}

// TODO : Use Generics and typeAlias to make the Repository class more general
class Repository <Element: Codable>: APIRepository {
    var path: String
    init(withPath path:String){
        self.path = path
    }
    
    func fetch(withCompletion completion: @escaping ([Element]?) -> Void) { }
    
    func fetch(withId id: Int, withCompletion completion: @escaping (Element?) -> Void) {
        let URLstring = path + "/\(id)"
        if let url = URL.init(string: URLstring){
            let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
                
//                let str = String(decoding: data!, as: UTF8.self)
//                print("Responding to request data: " + str)
                
                if let element = try? JSONDecoder().decode(Element.self, from: data!){
                    print("Running completion closure")
                    completion (element)
                }
            })
            task.resume()
        }
    }
    
    func create( a:Element, withCompletion completion: @escaping (Element?) -> Void ) {
        let url = URL.init(string: path)
        var urlRequest = URLRequest.init(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONEncoder().encode(a)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            let element = try? JSONDecoder().decode(Element.self, from: data!)
            completion (element)
        }
        task.resume()
    }
    
    func update( withId id:Int, a:Element ) {
        if let url = URL.init(string: path + "/\(id)"){
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "PUT"
            urlRequest.httpBody = try? JSONEncoder().encode(a)
            let task = URLSession.shared.dataTask(with: urlRequest)
            task.resume()
        }
    }
    
    func delete( withId id:Int ) {
        if let url = URL.init(string: path + "/\(id)"){
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "DELETE"
            let task = URLSession.shared.dataTask(with: urlRequest)
            task.resume()
        }
    }
}

