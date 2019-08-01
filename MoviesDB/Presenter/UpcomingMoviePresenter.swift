//
//  UpcomingMoviePresenter.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/29/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import Foundation

protocol UpcomingMoviePresenter {
    func getUpcomingList()
}

class UpcomingMoviePresenterImpl: UpcomingMoviePresenter {
    
    private var view: UpcomingMoviesView
    private var currentPage = 0
    private var isInProgress = false
    
    init(view: UpcomingMoviesView) {
        self.view = view
    }
    
    func getUpcomingList() {
        guard !isInProgress else { return }
        
        isInProgress = true
        currentPage += 1
        
        let request = UpcomingMovieRequest(page: currentPage)
        let apiClient = MovieDBAPIClient()
                
        apiClient.send(request) { [weak self] (response) in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let result):
                strongSelf.isInProgress = false
                let upcomingResult = result as! UpcomingResult
                strongSelf.view.setTotalCount(total: upcomingResult.totalResults)
                strongSelf.view.setMovieList(upcomingResult.results)
                break
            case .failure(let error):
                strongSelf.isInProgress = false
                print(error)
            }
        }
    }
}
