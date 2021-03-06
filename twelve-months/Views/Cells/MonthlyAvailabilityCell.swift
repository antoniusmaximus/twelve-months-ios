//
//  MonthlyAvailabilityCell.swift
//  twelve-months
//
//  Created by Anton Quietzsch on 25.11.20.
//  Copyright © 2020 Anton Quietzsch. All rights reserved.
//

import UIKit

class MonthlyAvailabilityCell: UITableViewCell {
    static let identifier = "MonthlyCell"

    private var availabilityView: AvailabilityView!
    private var ratioView: RatioView!
    private var stackView: UIStackView!

    private var type: OverviewSection!
    private var availability: Availability!
    private var ratio: Int!

    init(_ item: Food, in month: Month, from type: OverviewSection) {
        let index = Month.index(of: month)
        super.init(style: .default, reuseIdentifier: MonthlyAvailabilityCell.identifier)
        switch OverviewSection(rawValue: type.rawValue) {
        case .cultivation:
            availability = item.cultivationByMonth[index]
            availabilityView = CultivationView(for: availability, withLabels: true)
        case .importOnly:
            availability = item.importByMonth[index]
            availabilityView = ImportView(for: availability, withLabels: true)
        default: fatalError("Unexpectedly found illegal section \(type.rawValue)")
        }
        if let ratio = item.ratio?[index] {
            self.ratio = ratio
        }
        isUserInteractionEnabled = false
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    fileprivate func setupViews() {
        ratioView = RatioView(for: ratio, withLabels: true)
        stackView = UIStackView(arrangedSubviews: [availabilityView, ratioView])
        stackView.frame = frame
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
