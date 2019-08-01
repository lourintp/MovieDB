//
//  OverviewViewController.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/29/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupUI() {
        self.title = movie.title
        
        posterImageView.imageFromUrl(url: movie.posterPath ?? "")
        titleLabel.text = movie.title
        releaseDateLabel.text = "Release date: \(movie.formattedReleaseDate())"
        genreLabel.text = GenreGetter(movie.genreIds).getAll()
        overviewLabel.text = movie.overview ?? ""
    }
    
    deinit {
        print("OverviewViewController was deinitialized")
    }
    
}
