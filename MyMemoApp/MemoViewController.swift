//
//  MemoViewController.swift
//  MyMemoApp
//
//  Created by Kaho Matsumoto on 2017/06/22.
//  Copyright © 2017年 Kaho Matsumoto. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController {

    var memo: String?
    
    // 誤字った
    // テキストフィールド
    @IBOutlet weak var memoTexttField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.saveButton.isEnabled = false
        // memoがnilじゃなかったら編集モード
        if let memo = self.memo {
            self.memoTexttField.text = memo
            self.navigationItem.title = "Edit Memo"
        }
        self.updateSaveButtonState()
    }
    
    // テキストフィールドがemptyならsaveボタンは押せない
    
    private func updateSaveButtonState() {
        let memo = self.memoTexttField.text ?? ""
        self.saveButton.isEnabled = !memo.isEmpty
    }
    
    @IBAction func memoTextFieldChanged(_ sender: Any) {
        self.updateSaveButtonState()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancel(_ sender: Any) {
        if self.presentingViewController is UINavigationController {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // saveボタンなのかチェック
        guard let button = sender as? UIBarButtonItem,
        button === self.saveButton else {
            return
        }
        // memoに値を設定する
        self.memo = self.memoTexttField.text ?? ""
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
