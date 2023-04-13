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
        label.text = "Vista de Lisboa"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold) // Increase font size
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var exploreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Explorar transportes", for: .normal)
        button.setTitleColor(.white, for: .normal) // Set font color to white
        button.backgroundColor = UIColor.darkGray // Set background color to dark gray
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20) // Add padding to the text
        button.layer.cornerRadius = 5 // Add corner radius for a better appearance
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
        view.addSubview(subtitleLabel)
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
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Setup constraints for exploreButton
        NSLayoutConstraint.activate([
            exploreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exploreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
        
        // Setup constraints for subtitleLabel
        NSLayoutConstraint.activate([
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: Actions
    @objc private func exploreButtonTapped() {
        let mapViewController = MapViewController()
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}
