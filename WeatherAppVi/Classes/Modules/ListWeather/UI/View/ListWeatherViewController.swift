//
//  ListWeatherViewController.swift
//  WeatherAppViper
//
//  Created by Mena Gamal on 5/25/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ListWeatherViewController: UIViewController ,UITableViewDelegate{
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    var dataVariableArray: Variable<[Weather]> = Variable([])
    
    let disposeBag = DisposeBag()
    
    var eventHandler: ListPresenter!
    
    @IBOutlet weak var reloadBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupCellConfiguration()
        setupCellTapHandling()
        
        eventHandler = ListPresenter(vc: self)
        eventHandler.fetchDataFromServer()
        
    }
    
    func configureView() {
        navigationItem.title = "Current Weather"
        self.reloadBtn!.rx.tap.subscribe { _ in
            
            self.eventHandler.fetchDataFromServer()
            
            }.addDisposableTo(disposeBag)
        
    }
    
    private func setupCellConfiguration() {
        //Equivalent of cell for row at index path
        dataVariableArray.asObservable()
            .bind(to: weatherTableView.rx.items(cellIdentifier: ListCell.Identifier, cellType: ListCell.self)) { (row, weather, cell) in
                
                cell.setDetails(item: weather)
                
            }
            .disposed(by: disposeBag)
        
        
    }
    
    private func setupCellTapHandling() {
        weatherTableView
            .rx
            .modelSelected(Weather.self)
            .subscribe(onNext: {
                weather in
                if let selectedRowIndexPath = self.weatherTableView.indexPathForSelectedRow {
                    self.weatherTableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
                self.eventHandler?.showDetail(weather: weather)
                
            })
            .disposed(by: disposeBag)
    }
    
    
    func showAllCitiesWeather(_ data: [Weather]) {
        
        dataVariableArray.value = data
    }
    
    
}
