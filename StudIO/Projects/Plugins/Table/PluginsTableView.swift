//
//  PluginsTableView.swift
//  StudIO
//
//  Created by Arthur Guiot on 6/5/19.
//  Copyright © 2019 Arthur Guiot. All rights reserved.
//

import UIKit

extension PluginsVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = sections[section].list
        return rows.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sec = sections[section]
        return sec.title
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let rows = sections[section].list
        let row = rows[indexPath.row]
        
        let c = tableView.dequeueReusableCell(withIdentifier: "pluginCell", for: indexPath)
        
        let cell = c as! PluginCell
        cell.name.text = row.title
        cell.switch.isOn = row.enable
        
        cell.rowIndex = indexPath
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let row = indexPath.row
        guard var plugins = UserDefaults.standard.array(forKey: "plugins") as? [[String: String]] else { return [] }
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let _ = plugins.remove(at: row)
            UserDefaults.standard.set(plugins, forKey: "plugins")
            
            self.load()
        }
        
        return [delete]
    }
}

