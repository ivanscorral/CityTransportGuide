//
//  InfoView.swift
//  City Transport Guide
//
//  Created by Ivan Sanchez on 13/4/23.
//

import UIKit

class InfoView: UIView {
    private let mapElement: MapElement
    
    init(mapElement: MapElement) {
        self.mapElement = mapElement
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let parameters: [(key: String, value: String?)] = [
            ("Company Zone ID: ", "\(mapElement.companyZoneID)"),
            ("Resource Type: ", mapElement.resourceType?.rawValue),
            ("License Plate: ", mapElement.licencePlate),
            ("Range: ", mapElement.range.map { "\($0) m" }),
            ("Helmets: ", mapElement.helmets.map { "\($0)" })
        ]
        
        for (key, value) in parameters {
            if let value = value {
                let label = UILabel()
                let attributedString = NSMutableAttributedString()
                attributedString.append(NSAttributedString(string: key, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)]))
                attributedString.append(NSAttributedString(string: value, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
                label.attributedText = attributedString
                stackView.addArrangedSubview(label)
            }
        }
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: 200, height: 100) // Set the desired size for your InfoView
    }
}
