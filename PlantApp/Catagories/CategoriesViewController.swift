//
//  CategoriesViewController.swift
//  PlantApp
//
//  Created by Nagarjuna Naidu on 04/04/25.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var catagories = [CategoriesModel2]()
    var filteredCatagories = [CategoriesModel2]()
    var isfilterd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        callCatogoriesAPI()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isfilterd ? filteredCatagories.count : catagories.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print(catagories.count)
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell
        let item = isfilterd ? filteredCatagories[indexPath.section] : catagories[indexPath.section]
        cell.titleLable.text = item.name
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = isfilterd ? filteredCatagories[indexPath.section] : catagories[indexPath.section]
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = .clear
        return footer
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layoutMargins = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText : String ){
        if searchText.isEmpty {
            isfilterd = false
        }else{
            isfilterd = true
            filteredCatagories = catagories.filter {
                $0.name?.lowercased().contains(searchText.lowercased()) ?? false
                
            }
        }
        tableView.reloadData()
    }
    
    func callCatogoriesAPI(){
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        // step 1
        let urlString = "https://api.escuelajs.co/api/v1/categories"
        
        
        ApiServices.shared.fetchData(from: urlString, model: [CategoriesModel2].self) { (result) in
            //switch to handle response
            switch result{
                /*
                 If the API call and decoding are successful:
                 You store the decoded categories into your local array catagories.
                 You reload the table view on the main thread to update the UI.
                 🧠 UI updates must always happen on the main thread, hence the DispatchQueue.main.async.
                 */
            case .success(let catagories):
                self.catagories = catagories
                DispatchQueue.main.async { [self] in
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    
                }
            case .failure(let error):
                print("API error", error.localizedDescription)
            }
        }
        
        // step 2
        //        guard let url = URL(string: urlString) else {
        //            print("Invalid URL")
        //            return
        //        }
        //
        //        // step 3
        //        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in DispatchQueue.main.async {
        //            self.activityIndicator.stopAnimating()
        //            self.activityIndicator.isHidden = true
        //        }
        //            guard let data = data else {
        //                return
        //            }
        //            do {
        //                let decoder = JSONDecoder()
        //                let categories = try decoder.decode([CategoriesModel2].self, from: data)
        //                self.catagories = categories
        //                DispatchQueue.main.async {
        //                    self.tableView.reloadData()
        //                }
        //
        //
        //            } catch {
        //
        //            }
        //        }
        //        task.resume()
        //
        //    }
        //
        
    }
}
