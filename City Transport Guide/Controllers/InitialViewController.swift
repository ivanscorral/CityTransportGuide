//
//  InitialViewController.swift
//  City Transport Guide
//
//  Created by Ivan Sanchez on 12/4/23.
//

import UIKit
import Kingfisher

class InitialViewController: UIViewController {
    
    // MARK: ViewModel object
    private let viewModel: InitialViewModel
    
    // MARK: Initializers
    init(viewModel: InitialViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController SubViews
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Visita Lisboa"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 23, weight: .medium) // Set font size to 20
        label.backgroundColor = .clear // Set the background color of the label to clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var subtitleBackgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear // Set the background color to clear
        backgroundView.layer.cornerRadius = 6 // Set corner radius to 8
        backgroundView.layer.borderWidth = 1 // Set border width
        backgroundView.layer.borderColor = UIColor.lightGray.cgColor // Set border color
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()

    private lazy var exploreButton: UIButton = {
        let button = UIButton(type: .system)
        
        let buttonTitle = "Explorar transportes"
        let attributedTitle = NSAttributedString(string: buttonTitle,
                                                 attributes: [
                                                    .font: UIFont.boldSystemFont(ofSize: 21.5),
                                                    .foregroundColor: UIColor(white: 0.9, alpha: 1)
                                                 ])
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) // Set padding to 20
        button.layer.cornerRadius = 12.0 // Set corner radius to 20
        button.tintColor = UIColor(hex: "#F2C94C")
        button.backgroundColor = UIColor(hex: "#e68a00")
        button.addTarget(self, action: #selector(exploreButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    // MARK: UI Set-Up
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(subtitleBackgroundView) // Add the background view first
        view.addSubview(subtitleLabel) // Add the label on top of the background view
        view.addSubview(exploreButton)
        
        setupConstraints()
        
        viewModel.fetchImage { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let url):
                DispatchQueue.main.async {
                    self.imageView.kf.setImage(with: url)
                }
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
    }
    
    private func setupConstraints() {
        // Setup constraints for imageView
        // Setup constraints for imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Setup constraints for exploreButton
        NSLayoutConstraint.activate([
            exploreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exploreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            exploreButton.widthAnchor.constraint(equalToConstant: 255.0),
            exploreButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        // Setup constraints for subtitleLabel
        NSLayoutConstraint.activate([
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.centerYAnchor.constraint(equalTo: subtitleBackgroundView.centerYAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: subtitleBackgroundView.leadingAnchor, constant: 12),
            subtitleLabel.trailingAnchor.constraint(equalTo: subtitleBackgroundView.trailingAnchor, constant: -12),
            subtitleLabel.topAnchor.constraint(equalTo: subtitleBackgroundView.topAnchor, constant: 12),
            subtitleLabel.bottomAnchor.constraint(equalTo: subtitleBackgroundView.bottomAnchor, constant: -12)
        ])
        
        // Setup constraints for subtitleBackgroundView
        NSLayoutConstraint.activate([
            subtitleBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: +50) // Place background view above the button
        ])
        
        
        
    }
    
    // MARK: Actions
    @objc private func exploreButtonTapped() {
        let mapViewController = MapViewController()
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.hasPrefix("#") ? hex.index(after: hex.startIndex) : hex.startIndex
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0x00ff00) >> 8
        let b = (rgbValue & 0x0000ff)
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff,
            alpha: 1
        )
    }
}
