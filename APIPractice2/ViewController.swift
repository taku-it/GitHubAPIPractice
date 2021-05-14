//
//  ViewController.swift
//  APIPractice2
//
//  Created by 生田拓登 on 2021/05/13.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    var userName = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
    }
    
//    json decodeのための構造体
    struct User: Codable{
        let total_count: Int
        let incomplete_results: Bool
        let items: [Item]
        
        
        struct Item: Codable {
            let login: String
            let id: Int
            let node_id: String
            let avatar_url: URL
            let gravatar_id: String?
            let url: URL
            let html_url: URL
            let followers_url: URL
            let subscriptions_url: URL
            let organizations_url: URL
            let repos_url: URL
            let received_events_url: URL
            let type: String
            let score: Double
        }
    }
    
    
    func searchGithubUser(query: String) {
        //        githubのuser名検索結果を表示
        let url = URL(string: "https://api.github.com/search/users?q=" + query)!
        let request = URLRequest(url: url)
        let decoder: JSONDecoder = JSONDecoder()
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let user: User = try decoder.decode(User.self, from: data)
                print(user)
            } catch let e {
                print("JSON Decode Error :\(e)")
            }
        }
        task.resume()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        userName = nameTextField.text!
        searchGithubUser(query: userName)
        nameTextField.resignFirstResponder()
    }
    
    
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameTextField.resignFirstResponder()
        userName = nameTextField.text!
        
        return true
    }
}

