//
//  ViewController.swift
//  Clima
//
//  Created by Onopriienko.Sergii on 07.04.2021.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    let mainStackView         = UIStackView()
    var searchStackView       = UIStackView()
    var temperatureStackView  = UIStackView()
    
    var backgroundImageView   = UIImageView()
    var weatherImageView      = UIImageView()
    
    let searchButton          = UIButton()
    let locationButton        = UIButton()

    let searchTextField       = UITextField()
    var temperatureValueLabel = UILabel()
    var cityNameLabel         = UILabel()
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate  = self
        searchTextField.delegate = self
        locationManager.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        configurateMainStackView(backGroundColor: .clear, axis: .vertical, aligment: .trailing,
                                 distribution: .fill, spacing: 5.0)
        
        assignBackgroundImageView()
        
        searchStackView = configurateNestedStackView(backGroundColor: .clear, axis: .horizontal,
                                                         alignment: .fill, distribution: .fill, spacing: 0.0)
        searchStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 0.0).isActive    = true
        searchStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -0.0).isActive = true
        
        setupLocationButton()
        searchStackView.addArrangedSubview(locationButton)
        setupSearchTextField()
        searchStackView.addArrangedSubview(searchTextField)
        setupSearchButton()
        searchStackView.addArrangedSubview(searchButton)
        
        setupWeatherImageView()
        
        temperatureStackView = configurateNestedStackView(backGroundColor: .clear, axis: .horizontal,
                                                          alignment: .fill, distribution: .fill, spacing: 0.0)
        
        temperatureValueLabel = setupCustomLabel(with: "21", font: .systemFont(ofSize: 80.0, weight: .black),
                                                          textColor: .black, textAlignment: .left, numOfLines: 1)
        let temperatureDegreeLabel = setupCustomLabel(with: "˚", font: .systemFont(ofSize: 100.0, weight: .light),
                                                           textColor: .black, textAlignment: .right, numOfLines: 1)
        let temperatureSymbolLabel = setupCustomLabel(with: "C", font: .systemFont(ofSize: 100.0, weight: .light),
                                                           textColor: .black, textAlignment: .right, numOfLines: 1)

        temperatureStackView.addArrangedSubview(temperatureValueLabel)
        temperatureStackView.addArrangedSubview(temperatureDegreeLabel)
        temperatureStackView.addArrangedSubview(temperatureSymbolLabel)
        
        cityNameLabel = setupCustomLabel(with: "Kyiv", font: .systemFont(ofSize: 50.0, weight: .light),
                                             textColor: .black, textAlignment: .center, numOfLines: 1)
        
        mainStackView.addArrangedSubview(cityNameLabel)
    }

    //MARK: - Configurate Main and Nested Stack View
    
    func configurateMainStackView(backGroundColor: UIColor, axis: NSLayoutConstraint.Axis,
                                  aligment: UIStackView.Alignment,
                                  distribution: UIStackView.Distribution, spacing: CGFloat) {
        view.addSubview(mainStackView)
        
        mainStackView.backgroundColor = backGroundColor
        mainStackView.axis = axis
        mainStackView.alignment = aligment
        mainStackView.distribution = distribution
        mainStackView.spacing = spacing
        
        createMaineStackViewConstraints()
    }
    
    func createMaineStackViewConstraints() {
        mainStackView.translatesAutoresizingMaskIntoConstraints                                                            = false
        mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive    = true
        mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -0.0).isActive = true
        mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive            = true
    }
    
    func configurateNestedStackView(backGroundColor: UIColor, axis: NSLayoutConstraint.Axis,
                                    alignment: UIStackView.Alignment,
                                    distribution: UIStackView.Distribution, spacing: CGFloat) -> UIStackView{
        let stackView = UIStackView()
        mainStackView.addArrangedSubview(stackView)

        stackView.backgroundColor = backGroundColor
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        
        stackView.translatesAutoresizingMaskIntoConstraints                                                 = false
        
        return stackView
    }
    
    //MARK: - Configurate Weather and Background ImageView
    
    func assignBackgroundImageView() {
        view.insertSubview(backgroundImageView, at: 0)
        
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        
        setupImageViewConstraints()
    }
    
    func setupImageViewConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupWeatherImageView() {
        let image = UIImage(systemName: "sun.max")
        weatherImageView.image = image
        weatherImageView.tintColor = .systemGray
        weatherImageView.contentMode = .scaleAspectFill
                        
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        
        mainStackView.addArrangedSubview(weatherImageView)
    }
    
    //MARK: - Setup Search ans Location Button
    
    func setupSearchButton() {
        searchButton.backgroundColor = .clear
        searchButton.tintColor = .black
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
//        searchButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        setupButtonConstraints(searchButton)
    }
    
    func setupLocationButton() {
        locationButton.backgroundColor = .clear
        locationButton.tintColor = .black
        locationButton.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        setupButtonConstraints(locationButton)
    }
    
    func setupButtonConstraints(_ button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints             = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive  = true
    }
    
    //MARK: - Setup Search Text Field
    
    func setupSearchTextField() {
        searchTextField.backgroundColor = .clear
        searchTextField.textAlignment = .right
        searchTextField.borderStyle = .roundedRect
        searchTextField.placeholder = "Search"
        searchTextField.font = UIFont.boldSystemFont(ofSize: 25.0)
        searchTextField.autocapitalizationType = .words
        searchTextField.returnKeyType = .go
        searchTextField.translatesAutoresizingMaskIntoConstraints             = false
    }
    
    //MARK: - Setup City and Temperature Label
    
    func setupCustomLabel(with text: String, font: UIFont, textColor: UIColor,
                                  textAlignment: NSTextAlignment, numOfLines: Int) -> UILabel {
        let myLable = UILabel()
        myLable.text = text
        myLable.font = font
        myLable.textColor = textColor
        myLable.textAlignment = textAlignment
        myLable.numberOfLines = numOfLines
      
        myLable.translatesAutoresizingMaskIntoConstraints = false
        
        return myLable
    }
        
    //MARK: - Button action
    
    @objc func buttonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}
