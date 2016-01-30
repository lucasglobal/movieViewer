//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by Lucas Andrade on 1/24/16.
//  Copyright © 2016 LucasRibeiro. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD


class MoviesViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barNetworkIssue: UIView!
    var movies: [NSDictionary]?
    var networkBarAppearing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)

        tableView.insertSubview(refreshControl, atIndex: 0)
        tableView.dataSource = self
        tableView.delegate = self
        
        self.refreshWithoutControl()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies{
            return movies.count
        }
        else{
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell",forIndexPath:  indexPath) as! MovieCell
        let movie = movies![indexPath.row]
        let tittle = movie["title"] as! String
        let overView = movie["overview"] as! String
        let posterPath = movie["poster_path"] as! String
        
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let imageURL = NSURL(string: baseURL + posterPath)
        
        cell.posterView.setImageWithURL(imageURL!)
        cell.titleLabel.text = tittle
        cell.overViewLabel.text = overView
        
   
        return cell
        
    }
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.tableView.reloadData()
                            
                            refreshControl.endRefreshing()
                            if self.networkBarAppearing{
                                self.animateBarNetworkIssueNormalPosition()
                            }
                    }
                }
                else{
                    print(error)
                    refreshControl.endRefreshing()
                    if !self.networkBarAppearing{
                        self.animateBarNetworkIssue()
                    }
                }
        })
        task.resume()
    }
    func refreshWithoutControl(){
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        // Display HUD right before the request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.tableView.reloadData()
                            
                            // Hide HUD once the network request comes back (must be done on main UI thread)
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                            if self.networkBarAppearing{
                                self.animateBarNetworkIssueNormalPosition()
                            }
                    }
                }
                else{
                    print(error)
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    if !self.networkBarAppearing{
                        self.animateBarNetworkIssue()
                    }
                }
        })
        task.resume()

    }
    func animateBarNetworkIssue(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.barNetworkIssue.frame = CGRectMake(self.barNetworkIssue.frame.origin.x, self.barNetworkIssue.frame.origin.y + 40, self.barNetworkIssue.frame.size.width, self.barNetworkIssue.frame.size.height)
            self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y + 40, self.tableView.frame.size.width, self.tableView.frame.size.height)
        })
        self.networkBarAppearing = true

    }
    func animateBarNetworkIssueNormalPosition(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.barNetworkIssue.frame = CGRectMake(self.barNetworkIssue.frame.origin.x, self.barNetworkIssue.frame.origin.y - 40, self.barNetworkIssue.frame.size.width, self.barNetworkIssue.frame.size.height)
            self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y - 40, self.tableView.frame.size.width, self.tableView.frame.size.height)
        })
        self.networkBarAppearing = false
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
