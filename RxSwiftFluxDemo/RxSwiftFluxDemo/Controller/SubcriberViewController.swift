//
//  ViewController.swift
//  DemoApp
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import UIKit
import RxSwiftFlux

class SubcriberViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var refreshControl = UIRefreshControl()

    private let subcriberDataSource = SubcriberDataSource()
    
    let subcriberStore = SubcriberStore.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        configureUI()
        observeStore()
        observeUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func configureUI() {
        view.backgroundColor = UIColor.lightGray
        navigationItem.title = "Subcribers"
        tableView.addSubview(refreshControl)

        subcriberDataSource.register(tableView: tableView)
    }

    private func observeStore() {

    }

    private func observeUI() {
        ActionCreator.invoke(action: SubcriberAction.Fetch())

        let rx_refreshControler = refreshControl.rx.controlEvent(.valueChanged)

        rx_refreshControler
            .map ({ _ in
                !self.refreshControl.isRefreshing
            })
            .filter({ $0 == false })
            .subscribe(onNext: { [unowned self] _ in
                self.refreshControl.beginRefreshing()
                ActionCreator.invoke(action: SubcriberAction.Fetch())
            })
            .addDisposableTo(rx_disposeBag)

        rx_refreshControler
            .map ({ _ in
                self.refreshControl.isRefreshing
            })
            .filter({ $0 == true })
            .subscribe(onNext: { _ in
                self.refreshControl.endRefreshing()
            })
            .addDisposableTo(rx_disposeBag)
    }
}

