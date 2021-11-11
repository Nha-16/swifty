//
//  ViewController.swift
//  swifty-demo
//
//  Created by Mavin on 10/11/21.
//

import UIKit
import ProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var tableVIew: UITableView!
    
    var articles: [Article] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // initializing the refreshControl
        tableVIew.refreshControl = UIRefreshControl()
        
        // add target to UIRefreshControl
        tableVIew.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        fetch()
    }
    
    @objc func refresh(){
        fetch()
    }
    
    func fetch(){
        ProgressHUD.show()
        Network.shared.fetchArticles { result in
            switch result{
            case .success(let articles):
                self.articles = articles
                self.tableVIew.reloadData()
                ProgressHUD.showSucceed("Get data successfully")
                self.tableVIew.refreshControl?.endRefreshing()
                
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
                self.tableVIew.refreshControl?.endRefreshing()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailArticle" {
            if let desVC = segue.destination as? DetailtViewController, let indexPath = sender as? IndexPath{

                let article = self.articles[indexPath.row]
                
                desVC.article = article
                
            }
            
           
            
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.articles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detailArticle", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellArticle", for: indexPath) as! ArticleTableViewCell
        cell.config(article: self.articles[indexPath.row])
        return cell
    }
    
    
}
