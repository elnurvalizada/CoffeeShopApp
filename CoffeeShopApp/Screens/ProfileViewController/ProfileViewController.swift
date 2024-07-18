//
//  ProfileViewController.swift
//  CoffeeShopApp
//
//  Created by Elnur Valizada on 27.06.24.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileList : [LeftLabelRightIconCell.Model] = [
        .init(text: "Personal info", icon: "info.circle"),
        .init(text: "Cards & Payments", icon: "creditcard"),
        .init(text: "Transaction History", icon: "checklist"),
        .init(text: "Privacy & Data", icon: "hand.raised.fill"),
        .init(text: "Account ID", icon: "person.text.rectangle")
    ]
    let securityList : [String] = ["2- factor authentication","Face ID","Passcode Lock"]
    
    
    let notificationList : [String] = ["Inbox messages","Tipping, Receipts & Orders"]
    
    let helpList : [LeftLabelRightIconCell.Model] = [
        .init(text: "Help", icon: "questionmark.circle"),
        .init(text: "Application Terms", icon: "newspaper"),
        .init(text: "Privacy Notice", icon: "lock"),
        .init(text: "Delete Account", icon: "chevron.right")
    ]
    
    private let tableView : UITableView = {
        let tv = UITableView()
        tv.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.identifer)
        tv.register(LeftLabelRightIconCell.self, forCellReuseIdentifier: LeftLabelRightIconCell.identifer)
        tv.register(LeftLabelRightButtonCell.self, forCellReuseIdentifier: LeftLabelRightButtonCell.identifer)
        tv.showsVerticalScrollIndicator = false
        tv.separatorColor = .mainBackground
        
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackground
        tableView.backgroundColor = .mainBackground
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        
        tableView.dataSource = self
        tableView.delegate = self
    }

}


extension ProfileViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return profileList.count
        case 2:
            return securityList.count
        case 3:
            return notificationList.count
        case 4:
            return helpList.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
        }
        else if indexPath.section == 1 {
            
            
        }
        else {
            
        }
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.identifer, for: indexPath) as! ProfileHeaderCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: LeftLabelRightIconCell.identifer, for: indexPath) as! LeftLabelRightIconCell
            cell.config(item: profileList[indexPath.row])
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: LeftLabelRightButtonCell.identifer, for: indexPath) as! LeftLabelRightButtonCell
            cell.config(title: securityList[indexPath.row])
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: LeftLabelRightButtonCell.identifer, for: indexPath) as! LeftLabelRightButtonCell
            cell.config(title: notificationList[indexPath.row])
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: LeftLabelRightIconCell.identifer, for: indexPath) as! LeftLabelRightIconCell
            cell.config(item: helpList[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}


extension ProfileViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerLabel = UILabel()
        headerLabel.font = .systemFont(ofSize: 20, weight: .bold)
        headerLabel.textColor = .black
        
        headerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        switch section {
        case 1:
            headerLabel.text = "Profile"
        case 2:
            headerLabel.text = "Security"
        case 3:
            headerLabel.text = "Notification Preferences"
        case 4:
            headerLabel.text = "Help & Policies"
        default:
            headerLabel.text = ""
        }
        
        return headerView
    }
    
}
