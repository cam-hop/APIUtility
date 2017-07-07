//
//  SubcriberDataSource.swift
//  DemoApp
//
//  Created by DUONG VANHOP on 2017/06/14.
//  Copyright © 2017年 DUONG VANHOP. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SubcriberDataSource: NSObject {

    weak var tableView: UITableView?
    let subcribers = Variable<[Subcriber]>([])
    
    fileprivate let subcriberStore: SubcriberStore = .shared

    func register(tableView: UITableView) {

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.registerCell(cell: SubcriberCell.self)
        self.tableView = tableView

        observeStore()
    }

    private func observeStore() {
        subcriberStore.subcribers.asObservable()
            .subscribe(onNext: { [unowned self] elements in
                self.subcribers.value = elements
                self.tableView?.reloadData()
            })
            .addDisposableTo(rx_disposeBag)
    }
}

extension SubcriberDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcribers.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: SubcriberCell.self)
        cell.configure(subcriber: subcribers.value[indexPath.row])
        return cell
    }
}

extension SubcriberDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.5
    }
}

extension SubcriberDataSource: UIScrollViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }
}
