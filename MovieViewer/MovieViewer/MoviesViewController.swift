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
    var descriptionBeingShown: Bool = false
    var cellBeingUsed: Bool = false
    var selectedMovie: NSDictionary!
    var endPoint: String!
    var cellBeingDetailed: Int = 123456789
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //navigationBar Settings
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true

        
        //set up refreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)

        tableView.insertSubview(refreshControl, atIndex: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clearColor()

        self.refreshWithoutControl()
        
        
        
    }
    func singleTapping(sender: UITapGestureRecognizer){
        
        if(descriptionBeingShown == false){
            let cell = sender.view as? MovieCell
            cellBeingDetailed = cell!.tag
            print("sendo mostrada agora")
            self.descriptionBeingShown = true
            
            UIView.animateWithDuration(1, animations: { () -> Void in
                cell?.posterView.frame = CGRectMake(cell!.posterView.frame.origin.x, cell!.posterView.frame.origin.y, cell!.posterView.frame.size.width - 200, cell!.posterView.frame.size.height - 200)
                
                cell?.labelMovieJustOne.frame = CGRectMake(cell!.labelMovieJustOne.frame.origin.x, cell!.posterView.frame.origin.y + cell!.posterView.frame.size.height + 10, cell!.labelMovieJustOne.frame.size.width, cell!.labelMovieJustOne.frame.size.height)
                
                cell?.overViewLabel.frame = CGRectMake(cell!.overViewLabel.frame.origin.x, cell!.labelMovieJustOne.frame.origin.y + cell!.labelMovieJustOne.frame.size.height + 5, cell!.overViewLabel.frame.size.width, cell!.overViewLabel.frame.size.height)
                
              
                cell?.buttonSeeMore.frame = CGRectMake(cell!.buttonSeeMore.frame.origin.x, cell!.overViewLabel.frame.origin.y + cell!.overViewLabel.frame.size.height + 10, cell!.buttonSeeMore.frame.size.width, cell!.buttonSeeMore.frame.size.height)

            })
            UIView.animateWithDuration(2, animations: { () -> Void in

                cell?.releaseDateLabelStatic.alpha = 1
                cell?.releaseDateLabelDynamic.alpha = 1
                cell?.voteLabelStatic.alpha = 1
                cell?.votesLabelDynamic.alpha = 1
                cell?.ratingLabelStatic.alpha = 1
                cell?.ratingsLabelDynamic.alpha = 1
                
            })

        }
        else if (descriptionBeingShown == true){
            let cell = sender.view as? MovieCell
            if(cellBeingDetailed == cell!.tag){
                self.descriptionBeingShown = false
                UIView.animateWithDuration(1, animations: { () -> Void in
                    cell?.posterView.frame = CGRectMake(cell!.posterView.frame.origin.x, cell!.posterView.frame.origin.y, cell!.posterView.frame.size.width + 200, cell!.posterView.frame.size.height + 200)
                    
                    cell?.overViewLabel.frame = CGRectMake(cell!.overViewLabel.frame.origin.x,cell!.overViewLabel.frame.origin.y + 250, cell!.overViewLabel.frame.size.width, cell!.overViewLabel.frame.size.height)
                    cell?.labelMovieJustOne.frame = CGRectMake(cell!.labelMovieJustOne.frame.origin.x,cell!.labelMovieJustOne.frame.origin.y + 220, cell!.labelMovieJustOne.frame.size.width, cell!.labelMovieJustOne.frame.size.height)
                    cell?.buttonSeeMore.frame = CGRectMake(cell!.buttonSeeMore.frame.origin.x,cell!.buttonSeeMore.frame.origin.y + 280, cell!.buttonSeeMore.frame.size.width, cell!.buttonSeeMore.frame.size.height)
                    
                    
                })
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    
                    cell?.releaseDateLabelStatic.alpha = 0
                    cell?.releaseDateLabelDynamic.alpha = 0
                    cell?.voteLabelStatic.alpha = 0
                    cell?.votesLabelDynamic.alpha = 0
                    cell?.ratingLabelStatic.alpha = 0
                    cell?.ratingsLabelDynamic.alpha = 0
                    
                })
                
            }

            }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView()
        returnedView.frame = CGRectMake(0, 0, 100, 60)
        returnedView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        let label = UILabel(frame: CGRectMake(10, 0, 500, 30))
        label.textColor = UIColor.yellowColor()
        let movie = movies![section]
        let tittle = movie["title"] as! String
        label.text = tittle
        label.font = UIFont(name: "HelveticaNeue-UltraLight", size: 26)
        returnedView.addSubview(label)
        
        return returnedView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let movies = movies{
            return movies.count - 1
        }
        else{
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell",forIndexPath:  indexPath) as! MovieCell
        cell.backgroundColor = .clearColor()
        let movie = movies![indexPath.section]
        let overView = movie["overview"] as! String
        let posterPath = movie["poster_path"] as! String
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let imageURL = NSURL(string: baseURL + posterPath)
        
        cell.posterView.setImageWithURL(imageURL!)
        cell.overViewLabel.text = overView
        cell.tag = indexPath.section
        let singleTap = UITapGestureRecognizer(target: self, action: "singleTapping:")
        cell.posterView.addGestureRecognizer(singleTap)
        cell.addGestureRecognizer(singleTap)
        
        let voteAverage = movie["vote_average"] as! Int
        let voteCount = movie["vote_count"] as! Int

        cell.releaseDateLabelDynamic.text = movie["release_date"] as? String
        cell.votesLabelDynamic.text = String(voteAverage)
        cell.ratingsLabelDynamic.text = String(voteCount)
        
        cell.buttonSeeMore.tag = cell.tag
        return cell
        
    }
  
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endPoint)?api_key=\(apiKey)")
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
                            print(self.endPoint)

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
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endPoint)?api_key=\(apiKey)")
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
                            print(self.endPoint)
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let moreInfoVC = segue.destinationViewController as! MoreInfoViewController
        moreInfoVC.movie = selectedMovie
    }

    @IBAction func actionMoreInfoScreen(sender: AnyObject) {
        
        let indexPathCell = NSIndexPath(forRow: 0, inSection: sender.tag)
        print(sender.tag)
        let cell = tableView.cellForRowAtIndexPath(indexPathCell) as! MovieCell
        
        selectedMovie = movies![sender.tag]
        
        

    }
    override func viewDidAppear(animated: Bool) {
        //navigationBar Settings
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true

    }
}


