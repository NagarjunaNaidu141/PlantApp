//
//  CategoriesViewController.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 04/04/25.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var catagories = [CategoriesModel2]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        callCatogoriesAPI()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(catagories.count)
        return catagories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
        
        let item = catagories[indexPath.row]
        print(item.name ?? "")
        cell.titleLable.text = item.name
        // cell.detailTextLabel?.text = item.slug
        cell.backgroundColor = .white
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = catagories[indexPath.row]
        // Ensure 'categories' is your data source array
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let productVC = storyboard.instantiateViewController(withIdentifier: "productVC") as? ProductViewController {
            productVC.selectedCategory = selectedCategory
            self.navigationController?.pushViewController(productVC, animated: true )
        }
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }
        
        func callCatogoriesAPI(){
            // step 1
            let urlString = "https://api.escuelajs.co/api/v1/categories"
            
            // step 2
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            // step 3
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                guard let data = data else {
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let categories = try decoder.decode([CategoriesModel2].self, from: data)
                    self.catagories = categories
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    
                } catch {
                    
                }
            }
            task.resume()
            
            
        }
        
    }

