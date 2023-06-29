//
//  SearchCityEndpoint.swift
//  WeatherAppNariman
//
//  Created by Nariman on 05.06.2023.
//

import Foundation

enum SearchCityEndpoint {
    case search(query: String)
}

extension SearchCityEndpoint: RequestProviding {
    var urlRequest: URLRequest {
        switch self {
        case .search(let query):
            guard let url = URL(string: Constants.apiHost + "search.json?key=\(Constants.apiKey)&q=\(query)&aqi=no") else { fatalError() }
            
            let urlRequest = URLRequest(url: url)
            return urlRequest
        }
        
        
    }
}
