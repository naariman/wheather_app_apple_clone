//
//  ViewController.swift
//  WeatherAppNariman
//
//  Created by Nariman on 18.05.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentConditionLabel: UILabel!
    @IBOutlet weak var currentRangeTemperatureLabel: UILabel!
    
    @IBOutlet weak var backgroundForecastView: UIView!
    @IBOutlet weak var forecastStackView: UIStackView!
    
    @IBOutlet weak var backgroundWeekView: UIView!
    @IBOutlet weak var weekStackView: UIStackView!
    
    @IBOutlet weak var menuButton: UIButton!
    
    private let dataSource: ForecastDataSource = .init()
    
    private var cityModel: CityModel? {
        didSet {
            configureUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundForecastViewSetup()
        
        backgroundWeekViewSetup()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        getData()
    }
    
    func backgroundForecastViewSetup() {
        backgroundForecastView.layer.cornerRadius = 8
        backgroundForecastView.backgroundColor = Color.blueBlackBackgroundColor
    }
    
    func backgroundWeekViewSetup() {
        backgroundWeekView.backgroundColor = Color.blueBlackBackgroundColor
        backgroundWeekView.layer.cornerRadius = 8
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        let viewController = CitiesViewController()
        navigationController?.pushViewController(viewController, animated: true)
        viewController.delegate = self
    }
    
    private func configureUI() {
        guard let cityModel = cityModel else { return }
        
        cityNameLabel.text = cityModel.name
        currentTemperatureLabel.text = cityModel.currentTemperature.tempStyle
        currentConditionLabel.text = cityModel.condition.text
        
        guard let maxTemperature = cityModel.maxTemperature, let minTemperature = cityModel.minTemperature else { return }
        currentRangeTemperatureLabel.text = "Макс.: \(maxTemperature.tempStyle), мин.: \(minTemperature.tempStyle)"
        
        
        weekStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        forecastStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }

        cityModel.forecastDays.forEach {
            let dayForecastView = WeekItemView()
            dayForecastView.configure(model: $0)
            weekStackView.addArrangedSubview(dayForecastView)
        }
        
        guard let currentDay = cityModel.forecastDays.first else { return }
        currentDay.hour.forEach {
            let forecastItemView = ForecastItemView()
            forecastItemView.configure(model: $0)
            forecastStackView.addArrangedSubview(forecastItemView)
        }
    }
    
    private func getData() {
        dataSource.getForecast(cityName: cityModel?.name ?? "Almaty", days: 10) { result in
            switch result {
            case .success(let cityModel):
                DispatchQueue.main.async {
                    self.cityModel = cityModel
                    print(cityModel)
                }
            case .failure(let error):
                print("error = \(error.localizedDescription)")
            }
        }
    }
}

extension ViewController: CitiesViewControllerDelegate {
    func didSelectCity(_ city: SearchCityModel) {
        cityModel?.name = city.name
        getData()
    }
}
