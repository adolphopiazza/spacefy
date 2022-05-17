//
//  LaunchDetailViewController.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 06/04/21.
//

import UIKit
import MapKit

class LaunchDetailViewController: SFYScrollViewController {

    private let mapView: MKMapView = MKMapView()
    private let launchTitle: SFYLabel = SFYLabel()
    private let countdownLabel: SFYLabel = SFYLabel()
    private let dateLabel: SFYLabel = SFYLabel()
    private let lineView: UIView = UIView()
    private let descriptionLabel: SFYLabel = SFYLabel()
    
    private var timer: Timer?
    var launch: LaunchModel? {
        didSet {
            guard let launch = launch else { return }
            
            setPinAndLocation(to: CLLocationCoordinate2D(latitude: CLLocationDegrees(launch.pad.latitude) ?? CLLocationDegrees(),
                                                         longitude: CLLocationDegrees(launch.pad.longitude) ?? CLLocationDegrees()),
                              pad: launch.pad.name)
            launchTitle.configure(text: launch.name, font: .systemFont(ofSize: 26, weight: .semibold))
            countdownLabel.configure(text: "ETA", font: .systemFont(ofSize: 22))
            dateLabel.configure(text: launch.net.formatTo(date: .launchesFormat), color: .secondaryLabel, font: .systemFont(ofSize: 20))
            descriptionLabel.configure(text: launch.mission?.description, font: .systemFont(ofSize: 20))
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        setupLaunchTitle()
        setupCountdownLabel()
        setupDateLabel()
        setupLineView()
        setupDescriptionLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer?.invalidate()
    }

}

//MARK: - Actions
extension LaunchDetailViewController {
    
    @objc private func updateTimer() {
        let df = DateFormatter()
        df.dateFormat = DateFormats.launchesFormat.rawValue
        
        guard let date = df.date(from: launch?.net ?? "") else { return }
        let components = Calendar.current.dateComponents([.month, .day, .hour, .minute, .second], from: Date(), to: date)
        
        countdownLabel.configure(text: "\(components.day ?? 0) days - \(components.hour ?? 0):\(components.minute ?? 0):\(components.second ?? 0)",
                                 font: .systemFont(ofSize: 22))
    }
    
}

//MARK: - Layouts
extension LaunchDetailViewController {
    
    private func setupMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.3)
        ])
    }
    
    private func setPinAndLocation(to coordinates: CLLocationCoordinate2D, pad: String) {
        let launchPoint: MKPointAnnotation = MKPointAnnotation()
        launchPoint.coordinate = coordinates
        launchPoint.title = pad
        
        mapView.addAnnotation(launchPoint)
        mapView.setCenter(coordinates, animated: true)
    }
    
    private func setupLaunchTitle() {
        contentView.addSubview(launchTitle)
        
        launchTitle.textAlignment = .center
        
        NSLayoutConstraint.activate([
            launchTitle.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 15),
            launchTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            launchTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    private func setupCountdownLabel() {
        contentView.addSubview(countdownLabel)
        
        countdownLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            countdownLabel.topAnchor.constraint(equalTo: launchTitle.bottomAnchor, constant: 30),
            countdownLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            countdownLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    private func setupDateLabel() {
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: countdownLabel.bottomAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: countdownLabel.centerXAnchor)
        ])
    }
    
    private func setupLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lineView)
        
        lineView.backgroundColor = UIColor.secondaryLabel
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30),
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
}
