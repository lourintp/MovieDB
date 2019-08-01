//
//  MovieTableViewCell.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/28/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var upcomingDateLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with movie: Movie?) {
        if let movie = movie {
            changeVisibility(alpha: 1.0)
            activityIndicator.stopAnimating()
            
            titleLabel.text = movie.originalTitle
            upcomingDateLabel.text = movie.formattedReleaseDate()
            genreLabel.text = GenreGetter(movie.genreIds).getAll()
            backdropImage.imageFromUrl(url: movie.posterPath ?? "")            
        } else {
            changeVisibility()
            activityIndicator.startAnimating()
        }
    }
    
    private func changeVisibility(alpha: CGFloat = 0) {
        titleLabel.alpha = alpha
        upcomingDateLabel.alpha = alpha
        genreLabel.alpha = alpha
        backdropImage.alpha = alpha
    }

}
