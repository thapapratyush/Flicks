//
//  MovieViewController.swift
//  iFindMovies
//
//  Created by Pratyush on 2/5/17.
//  Copyright © 2017 Pratyush. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataEnteredDelegate  {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UILabel!
    
    var movies: [NSDictionary]?
    var filteredData: [NSDictionary]?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "iFindMovies"
        
        errorView.isHidden = true
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(dataDictionary)
                    
                    self.movies = dataDictionary["results"] as? [NSDictionary]
                    self.tableView.reloadData()
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    refreshControl.endRefreshing()
                    
                }else {
                    self.errorView.isHidden = false
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @available(iOS 2.0, *)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let movies = movies{return movies.count}else{return 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        let posterPath = movie["poster_path"] as! String
        let posterURLbase = "https://image.tmdb.org/t/p/w342"
        let imageURL = NSURL(string: posterURLbase + posterPath)
        
        cell.titleLabel!.text = title
        cell.overview!.text = overview
        cell.posterView.setImageWith(imageURL as! URL)
        
        return cell
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        // When there is no data, refresh tableView
        self.tableView.reloadData()
        
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
