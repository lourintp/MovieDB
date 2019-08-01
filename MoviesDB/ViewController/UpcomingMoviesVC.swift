//
//  UpcomingMoviesVC.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/28/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import UIKit

protocol UpcomingMoviesView {
    func setMovieList(_ movies: [Movie])
    func setTotalCount(total: Int)
}

class UpcomingMoviesVC: UIViewController, UpcomingMoviesView {
    
    @IBOutlet weak var tableView: UITableView!    
    
    private var presenter: UpcomingMoviePresenter!
    private var movieList: [Movie] = []
    private var filteredMovies = [Movie]()
    private let cellIdentifier = "movieCell"
    private var totalCount: Int = 0
    private var selectedMovie: Movie?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        presenter = UpcomingMoviePresenterImpl(view: self)
        presenter.getUpcomingList()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search upcoming movies..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    
    func setMovieList(_ movies: [Movie]) {
        self.movieList.append(contentsOf: movies)
        tableView.reloadData()
        
        let indexPathsToReload = self.calculateIndexPathsToReload(from: movies)
        self.onFetchCompleted(with: indexPathsToReload)        
    }
    
    func setTotalCount(total: Int) {
        self.totalCount = total
    }
    
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {        
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            tableView.isHidden = false
            tableView.reloadData()
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? OverviewViewController, let movie = selectedMovie {
            dest.movie = movie
        }
    }
}

extension UpcomingMoviesVC: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isFiltering()) {
            return filteredMovies.count
        }
        return totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieTableViewCell
        
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else if (isFiltering()) {
            cell.configure(with: filteredMovies[indexPath.row])
        } else {
            cell.configure(with: movieList[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (isFiltering()) {
            selectedMovie = filteredMovies[indexPath.row]
        } else {
            selectedMovie = movieList[indexPath.row]
        }
        performSegue(withIdentifier: "toOverview", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            presenter.getUpcomingList()
        }
    }
}

extension UpcomingMoviesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterForText(searchController.searchBar.text!)
    }
    
    
}

extension UpcomingMoviesVC {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= movieList.count
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    
    
    private func calculateIndexPathsToReload(from newMovies: [Movie]) -> [IndexPath] {
        let startIndex = movieList.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterForText(_ searchText: String) {
        filteredMovies = movieList.filter({( movie: Movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}
