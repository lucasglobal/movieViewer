//
//  MoreInfoViewController.swift
//  MovieViewer
//
//  Created by Lucas Andrade on 1/31/16.
//  Copyright © 2016 LucasRibeiro. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var imageBanner: UIImageView!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelOverviewStatic: UILabel!
    @IBOutlet weak var labelOriginalLanguage: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelOriginalLanguageStatic: UILabel!
    @IBOutlet weak var labelPopularityStatic: UILabel!
    @IBOutlet weak var labelPopularity: UILabel!
    @IBOutlet weak var labelMovieForAdultsStatic: UILabel!
    @IBOutlet weak var labelVoteAverageStatic: UILabel!
    @IBOutlet weak var labelVoteAverage: UILabel!
    @IBOutlet weak var labelVoteCountStatic: UILabel!
    @IBOutlet weak var labelVoteCount: UILabel!
    
    @IBOutlet weak var labelMovieForAdults: UILabel!
    @IBOutlet weak var labelReleaseDateStatic: UILabel!
    @IBOutlet weak var labelInformationsStatic: UILabel!
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(movie)
        let posterPath = movie["poster_path"] as! String
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let imageURL = NSURL(string: baseURL + posterPath)
        
        
        self.labelName.text = movie["title"] as? String
        self.imageBanner.setImageWithURL(imageURL!)
        
        
        //scrollViewSettings
        self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.view.frame.width, self.view.frame.height)
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 3, 1)
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true
        
        //when needed to put in other pages of ScrollView
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        
        //putting labels in correct pages of scrollView
        self.labelOverview.frame = CGRectMake(scrollViewWidth*1 + self.labelOverview.frame.origin.x, self.labelOverview.frame.origin.y, self.labelOverview.frame.size.width, self.labelOverview.frame.size.height)
        self.labelOverviewStatic.frame = CGRectMake(scrollViewWidth*1 + self.labelOverviewStatic.frame.origin.x, self.labelOverviewStatic.frame.origin.y, self.labelOverviewStatic.frame.size.width, self.labelOverviewStatic.frame.size.height)
        self.labelInformationsStatic.frame = CGRectMake(scrollViewWidth*2 + self.labelInformationsStatic.frame.origin.x, self.labelInformationsStatic.frame.origin.y, self.labelInformationsStatic.frame.size.width, self.labelInformationsStatic.frame.size.height)
        self.labelReleaseDateStatic.frame = CGRectMake(scrollViewWidth*2 + self.labelReleaseDateStatic.frame.origin.x, self.labelReleaseDateStatic.frame.origin.y, self.labelReleaseDateStatic.frame.size.width, self.labelReleaseDateStatic.frame.size.height)
        self.labelDate.frame = CGRectMake(scrollViewWidth*2 + self.labelDate.frame.origin.x, self.labelDate.frame.origin.y, self.labelDate.frame.size.width, self.labelDate.frame.size.height)
        self.labelOriginalLanguageStatic.frame = CGRectMake(scrollViewWidth*2 + self.labelOriginalLanguageStatic.frame.origin.x, self.labelOriginalLanguageStatic.frame.origin.y, self.labelOriginalLanguageStatic.frame.size.width, self.labelOriginalLanguageStatic.frame.size.height)
        self.labelOriginalLanguage.frame = CGRectMake(scrollViewWidth*2 + self.labelOriginalLanguage.frame.origin.x, self.labelOriginalLanguage.frame.origin.y, self.labelOriginalLanguage.frame.size.width, self.labelOriginalLanguage.frame.size.height)
        self.labelPopularityStatic.frame = CGRectMake(scrollViewWidth*2 + self.labelPopularityStatic.frame.origin.x, self.labelPopularityStatic.frame.origin.y, self.labelPopularityStatic.frame.size.width, self.labelPopularityStatic.frame.size.height)
        self.labelPopularity.frame = CGRectMake(scrollViewWidth*2 + self.labelPopularity.frame.origin.x, self.labelPopularity.frame.origin.y, self.labelPopularity.frame.size.width, self.labelPopularity.frame.size.height)
        self.labelMovieForAdultsStatic.frame = CGRectMake(scrollViewWidth*2 + self.labelMovieForAdultsStatic.frame.origin.x, self.labelMovieForAdultsStatic.frame.origin.y, self.labelMovieForAdultsStatic.frame.size.width, self.labelMovieForAdultsStatic.frame.size.height)
        self.labelMovieForAdults.frame = CGRectMake(scrollViewWidth*2 + self.labelMovieForAdults.frame.origin.x, self.labelMovieForAdults.frame.origin.y, self.labelMovieForAdults.frame.size.width, self.labelMovieForAdults.frame.size.height)
        self.labelVoteAverageStatic.frame = CGRectMake(scrollViewWidth*2 + self.labelVoteAverageStatic.frame.origin.x, self.labelVoteAverageStatic.frame.origin.y, self.labelVoteAverageStatic.frame.size.width, self.labelVoteAverageStatic.frame.size.height)
        self.labelVoteAverage.frame = CGRectMake(scrollViewWidth*2 + self.labelVoteAverage.frame.origin.x, self.labelVoteAverage.frame.origin.y, self.labelVoteAverage.frame.size.width, self.labelVoteAverage.frame.size.height)
        self.labelVoteCountStatic.frame = CGRectMake(scrollViewWidth*2 + self.labelVoteCountStatic.frame.origin.x, self.labelVoteCountStatic.frame.origin.y, self.labelVoteCountStatic.frame.size.width, self.labelVoteCountStatic.frame.size.height)
        self.labelVoteCount.frame = CGRectMake(scrollViewWidth*2 + self.labelVoteCount.frame.origin.x, self.labelVoteCount.frame.origin.y, self.labelVoteCount.frame.size.width, self.labelVoteCount.frame.size.height)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    
}
