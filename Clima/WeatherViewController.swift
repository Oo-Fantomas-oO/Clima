//
//  ViewController.swift
//  Clima
//
//  Created by Onopriienko.Sergii on 07.04.2021.
//

import UIKit

class WeatherViewController: UIViewController {

    private let mainStackView       = UIStackView()
    private var searchStackView     = UIStackView()
    private var backgroundImageView = UIImageView()
    
    private let searchButton        = UIButton()
    private let locationButton      = UIButton()

    private let searchTextField     = UITextField()
    
//    var myView: UIView = {
//        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 150))
//        myView.translatesAutoresizingMaskIntoConstraints = false
//        myView.backgroundColor = .systemPink
//        return myView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateMainStackView(backGroundColor: .clear, axis: .vertical, aligment: .trailing,
                                 distribution: .fillProportionally, spacing: 5.0)
        
        assignBackgroundImageView()
        
        searchStackView = configurateNestedStackView(backGroundColor: .clear, axis: .horizontal,
                                                         alignment: .fill, distribution: .fill, spacing: 10.0)
        
        setupLocationButton()
        searchStackView.addArrangedSubview(locationButton)
        setupSearchTextField()
        searchStackView.addArrangedSubview(searchTextField)
        setupSearchButton()
        searchStackView.addArrangedSubview(searchButton)
        

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
        stackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 0.0).isActive    = true
        stackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -0.0).isActive = true
        return stackView
    }
    
    //MARK: - Configurate Weather and Background ImageView
    
    func assignBackgroundImageView() {
        view.insertSubview(backgroundImageView, at: 0)
        
        backgroundImageView.image = UIImage(named: "background")
//        backgroundImageView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
        backgroundImageView.contentMode = .scaleAspectFill
        
        setupConstraints()
    }
    
    func setupConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configurateWeatherImageView () -> UIImageView {
        let weatherImage = UIImageView()
        weatherImage.image = UIImage(named: "rain")
        weatherImage.contentMode = .scaleAspectFit
                
        return weatherImage
    }
    
    //MARK: - Setup Search ans Location Button
    
    func setupSearchButton() {
        searchButton.backgroundColor = .clear
        searchButton.tintColor = .black
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
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
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive  = true
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
    }
        
    //MARK: - Button action
    
    @objc func buttonPressed(_ sender: UIButton) {
        
        print(sender.titleLabel!)
    }
}
