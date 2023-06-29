//
//  CitiesViewController.swift
//  WeatherAppNariman
//
//  Created by Nariman on 27.05.2023.
//

import UIKit

protocol CitiesViewControllerDelegate: AnyObject {
    func didSelectCity(_ city: SearchCityModel)
}

class CitiesViewController: UIViewController {
    
    private var cities: [SearchCityModel] = [] {
        didSet {
            tableView.reloadData()  
        }
    }
    private let dataSource = SearchCityDataSource()
    
    private var isSearchBarEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        !isSearchBarEmpty && searchController.isActive
    }
    
    weak var delegate: CitiesViewControllerDelegate?

    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private var searchController: UISearchController = {
        let viewController = UISearchController(searchResultsController: nil)
        
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    func setupUI() {
        view.backgroundColor = .black
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        title = "Погода"
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.searchController = searchController
        searchController.delegate = self
        searchController.searchBar.delegate = self
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else { fatalError() }
        cell.configure(model: cities[indexPath.row])
        
        return cell
    }
    
    
}

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        97
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCity(cities[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

extension CitiesViewController: UISearchControllerDelegate {
    
}

extension CitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 0 else {
            tableView.reloadData()
            return
        }
        dataSource.searchCity(query: searchText) { [weak self] result in
            switch result {
            case .success(let cities):
                DispatchQueue.main.async {
                    self?.cities = cities
                }
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
            
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }
    
}

