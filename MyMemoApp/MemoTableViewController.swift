//
//  MemoTableViewController.swift
//  MyMemoApp
//
//  Created by Kaho Matsumoto on 2017/06/22.
//  Copyright © 2017年 Kaho Matsumoto. All rights reserved.
//

import UIKit

class MemoTableViewController: UITableViewController {
    
    // UserDefaults
    let userDefaults = UserDefaults.standard
    

//    var memos =
//        ["blue", "red", "pink"] // 初期値
    var memos = [[[String: Any]]]()
    /*
     [
        [
            "note": "memo1"
            "date": 2017.6.23
        ],
        [
            "note": "memo2"
            "date": 2017.6.23
        ],
            :
     ]
     */
    
    
    
    // saveでメモリストへ画面遷移するときの動作
    @IBAction func unwindToMemoList(sender: UIStoryboardSegue)
    {
        // nilじゃなかったらメモへ追加
        guard let sourceVC = sender.source as?
            MemoViewController, let note = sourceVC.note, let date = sourceVC.date else
            {
            return
        }
        // 編集だったら更新
        let entry: [[String : Any]] = [["note":note, "date":date]]
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.memos[selectedIndexPath.row] = entry
        } else {
            // 新規メモなら追加
            self.memos.append(entry)
        }
        // ufへの追加
        self.userDefaults.set(self.memos, forKey: "memos")
        // メモリストの更新
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // objectがnilじゃなかったらmemosに値をセット
        if self.userDefaults.object(forKey: "memos") != nil {
            self.memos = self.userDefaults.array(forKey: "memos") as! [[[String : Any]]]
        } else {
            // nilだったら初期値をセット
//            self.memos = ["memo1", "memo2", "memo3"]
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.memos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath)

        // Configure the cell...
        let val = self.memos[indexPath.row]
        let v = val[0]
        cell.textLabel?.text = v["note"] as? String
        let date = v["date"] as! Date
        cell.detailTextLabel?.text = date.description

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "section-\(section)"
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    // Delete動作
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.memos.remove(at: indexPath.row)
            self.userDefaults.set(self.memos, forKey: "memos")
            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else {
            return
        }
        if identifier == "editMemo" {
            let memoVC = segue.destination as!
            MemoViewController
            let val = self.memos[(self.tableView.indexPathForSelectedRow?.row)!]
            let v = val[0]
            memoVC.note = v["note"] as? String
            memoVC.date = v["date"] as? Date
            
        }
    }
    

}
