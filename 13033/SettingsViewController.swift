//
//  SettingsViewController.swift
//  13033
//
//  Created by Nikolaos Athanasiou on 15/4/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import UIKit
import EasyPeasy
import SafariServices
import Buglife

class SettingsViewController: UIViewController {
    var shouldUpdateConstraints = true
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateViewConstraints()
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func setupView() {
        title = NSLocalizedString("settingsTitle", comment: "The settings view navBar title")
        view.backgroundColor = ColorScheme().background
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = ColorScheme().background
        view.addSubview(tableView)
        
    }
    
    override func updateViewConstraints() {
        if shouldUpdateConstraints {
            shouldUpdateConstraints = false
            
            tableView.easy.layout(
                Edges()
            )
            
        }
        super.updateViewConstraints()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Setting.sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Setting.sections[section].settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ILTableViewCell()
        let setting = Setting.sections[indexPath.section].settings[indexPath.row]
        cell.textLabel?.text = setting.title
        cell.textLabel?.textColor = setting.isLink ? UIColor.systemBlue : ColorScheme().surfaceContrast
        cell.imageView?.image = setting.image
        cell.id = setting.id
        cell.imageView?.roundCorners(.allCorners, radius: 4)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Setting.sections[section].title
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return Setting.sections[section].footer.isEmpty ? nil : Setting.sections[section].footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? ILTableViewCell else {return}
        if selectedCell.id == SettingID.review.rawValue {
            StoreUtils.rateApp()
        }
        if selectedCell.id == SettingID.terms.rawValue {
            WebUtils.showSite(self, url: URL(string: "https://athanasiou.me/legal/app-13033/terms-of-service.html")!)
        }
        if selectedCell.id == SettingID.privacy.rawValue {
            WebUtils.showSite(self, url: URL(string: "https://athanasiou.me/legal/app-13033/privacy.html")!)
        }
        if selectedCell.id == SettingID.share.rawValue {
            StoreUtils.shareApp(self)
        }
        if selectedCell.id == SettingID.bug.rawValue {
            AlertUtils.showAlert(self, title: NSLocalizedString("bugAlertTitle", comment: ""), message: NSLocalizedString("bugAlert", comment: ""))
        }
    }
        
}
