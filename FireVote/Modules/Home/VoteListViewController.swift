//
//  VoteListViewController.swift
//  FireVote
//
//  Created by Deng on 2019/9/3.
//  Copyright © 2019 Li. All rights reserved.
//

import UIKit

class VoteListViewController: ViewController {
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.backgroundColor = view.backgroundColor
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(cellType: VoteListCell.self)
    return tableView
  }()
  
  private var voteInfoList: [VoteListInfo] = []
  private var page = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    requestVoteList(reload: true)
  }
  
  private func setupView() {
    title = "投票"
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    tableView.mj_header = PWRefreshHeader(refreshingBlock: {
      self.requestVoteList(reload: true)
    })
    tableView.mj_footer = PWRefreshFooter(refreshingBlock: {
      self.requestVoteList(reload: false)
    })
    tableView.mj_footer.isHidden = true
  }
  
  private func requestVoteList(reload: Bool) {
    reload ? page = 0 : (page = page + 1)
    voteInfoList.count == 0 ? HUD.loading() : HUD.hide()
    VoteManager.voteList(type: .vote, page: page) { result in
      if reload {
        self.voteInfoList.removeAll()
      }
      self.voteInfoList = VoteManager.readVoteListList()
      self.tableView.reloadData()
      self.tableView.endRefreshing(isNoMoreData: true)
    }
  }
}

extension VoteListViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return voteInfoList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let info = self.voteInfoList[indexPath.row]
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: VoteListCell.self)
    cell.update(info: info)
    return cell
  }
}

extension VoteListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return tableView.fd_heightForCell(withIdentifier: VoteListCell.self.reuseIdentifier, cacheBy: indexPath, configuration: { (cell) in
      let info = self.voteInfoList[indexPath.row]
      ( cell! as! VoteListCell).update(info: info)
    })
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = VoteDetailsViewController()
    let info = self.voteInfoList[indexPath.row]
    vc.optionList = info.vote.voteOptions
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0.1
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.1
  }
  
}
