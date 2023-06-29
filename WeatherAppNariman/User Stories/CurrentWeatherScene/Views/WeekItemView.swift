//
//  WeekItemView.swift
//  WeatherAppNariman
//
//  Created by Nariman on 21.05.2023.
//

import UIKit
import Kingfisher

class WeekItemView: UIView {
    
    private var dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var minTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private var lineView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private var maxTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private var minTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 9)
        label.text = "мин"
        
        return label
    }()
    
    private var maxTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 9)
        label.text = "макс"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(dayLabel)
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dayLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        addSubview(icon)
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 16),
            icon.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor)
        ])
        
        addSubview(minTempLabel)
        NSLayoutConstraint.activate([
            minTempLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
            minTempLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20)
        ])
        
        addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: minTempLabel.trailingAnchor, constant: 8),
            lineView.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor, constant: 4),
            lineView.heightAnchor.constraint(equalToConstant: 3),
        ])
        
        addSubview(maxTempLabel)
        NSLayoutConstraint.activate([
            maxTempLabel.leadingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: 8),
            maxTempLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
            maxTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        addSubview(minTitleLabel)
        NSLayoutConstraint.activate([
            minTitleLabel.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            minTitleLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor, constant: -4)
        ])
        
        addSubview(maxTitleLabel)
        NSLayoutConstraint.activate([
            maxTitleLabel.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
            maxTitleLabel.centerYAnchor.constraint(equalTo: minTitleLabel.centerYAnchor)
        ])
    }
    
    func configure(model: ForecastDayModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: model.date) {
            dayLabel.text = dateFormatter.shortWeekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        }
        
        guard let url = URL(string: model.day.condition.iconURLPath) else { return }
        icon.kf.setImage(with: url)

        let intMin = Int(model.day.minTemperature)
        minTempLabel.text = intMin.tempStyle
        let intMax = Int(model.day.maxTemperature)
        maxTempLabel.text = intMax.tempStyle
    }

}
