//
//  SettingTableViewController.swift
//  FinalProject
//
//  Created by SUNG HAO LIN on 2017/4/26.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    
    
    @IBOutlet var setTableView: UITableView!
    
    var dataSectionArray: [String] = ["上課帳號", "請假相關規定", "補課規定", "特殊狀況", "老師/時段", "暫停課程", "退費辦法", "轉讓課程", "休假日", "課程期限"]
    var dataCellArray: [[String]] = [
        ["學員完成報名手續後，本學苑將在第一次上課後為其開通帳號。若學員於課後仍未開通帳號，請盡速洽詢客服人員，避免日後漏失郵件或遭防火牆阻擋。"],
        ["若學員需請假，可預先透過電話向學苑請假，請假時間最晚需於上課二小時以前完成。若當日請假未在課程二小時前提出，該堂則視為曠課 ，學苑將自動扣除堂數。請勿逕自留言至Line通知請假，避免發生離線留言未現之爭議。本學苑亦無接受Email請假，所有出缺勤及請假紀錄皆以電話紀錄為依據，以維持紀錄之公正性。"],
        ["學員請假後請與學苑協調補課時間，於確認好補課時段後，以 Line 或Email通知學員與老師。學員上課時間遲到超過二十分鐘則視為缺席，老師則無補課之義務。若老師上課遲到，則須補足學員上課時間。學員已準備好上課，而老師於上課時間逾十分鐘未上課，請立即 以Line或電話通知學苑，本學苑將補回未上課之課堂。截止期限最後一個月，若剩餘堂數超過總購買堂數三分之一，除原定課表課程外，學員不得當月要求額外加課或補課。"],
        ["老師/學員任何一方如遇不可抗拒之因素等(如網路不穩、網路斷線、停電)，造成課程中斷，請立即停止課程並當日以 Line或電話通知學苑，未完成時間依據上課紀錄另行擇期補足。"],
        ["若與授課老師有不適應情形，學員可請求更換老師，請至少上三堂課後，提出具體需求及理由再申請更換老師。每月(三十天)不得更換超過一次。任課老師因合約期滿或私人因素無法完成全期課程，本學苑有重新更換老師之權利。若學員需更換原有上課時段，請於一星前通知學苑，以便行政作業。 若因要求更換時段，老師課程已滿，本學苑則有重新安排老師之義務。如無法找到適合的老師，學苑保留退回學員剩餘款項的權利。"],
        ["學員因故必須暫停課程，學苑同意保留剩餘課程，原有截止期限依暫停時間順延，最多三個月。學員須於復課前一周主動與本學苑聯絡，並繳交收手續費 NT$800 申請復課。本學苑無告知復課之義務。若未申請辦理延期，或無故停止上課則視為自動放棄課程。"],
        ["報名後至上完第一堂課以前，學費可以全額退費。開課後上課一個月內堂數未超過三分之一課程，扣除實際上課堂數後，學費則予以退費七成。若超過一個月或上課堂數超過三分之一課程（含三分之一)，扣除實際上課堂數，學費則予以退費五成。若上課堂數超過二分之一，則不予接受辦理退費。已辦理延期者則無法退費。教材費均無法退費，所有退費辦理均需扣除工本費 NT$800。"],
        ["學習中途因故無法完成已購買之課程，可將剩餘堂數轉讓他人，承繼轉讓課程者得支付 NT$1200 手續費。本中心有義務比照新學員，並另外安排程度評估及課程安排。"],
        ["學苑休假比照行政院人資部門所公告的國定假日，其他臨時休假日會於最新消息或Line群組上面公布，請隨時多加留意。"],
        ["甲方為哥布林程式教育學苑，乙方為學員。乙方繳款後視同同意遵守以上條款。老師請假，甲方有義務在期限前安排補課。 乙方請假，請與甲方安排時間補課。乙方若因個人因素請假過多，未能如期在期限前完成課程或補課，不得以任何理由要求延長期限。乙方需依報名時規章約定的上課截止日期前完成課程。"]
    ]
    
    var isExpand: [Bool] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //自適應高度
        self.setTableView.rowHeight = UITableViewAutomaticDimension
        self.setTableView.estimatedRowHeight = 35
        
        // 用0代表收起，非0（不一定是1）代表展開，預設為全部都是收起的狀態
        for _ in 0..<dataSectionArray.count {
            isExpand.append(false)
        }
    }

   

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSectionArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isExpand[section] == true {
            let readCellArray = dataCellArray[section]
            return readCellArray.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = setTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataCellArray[indexPath.section][indexPath.row]
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        cell.textLabel?.numberOfLines = 0
        print(dataCellArray[indexPath.section])
        print(dataCellArray[indexPath.section][0])
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = setTableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! SettingTableViewCell
        headerCell.cellLabel.font = UIFont.boldSystemFont(ofSize: 16)
        headerCell.cellLabel.text = dataSectionArray[section]
        
        headerCell.cellButton.tag =  666 + section
        headerCell.cellButton.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        
        //這裡要傳回cell的contentView，不然按下按鈕後會消失
        return headerCell.contentView
    }
    
    func buttonAction(sender:UIButton) {
        let section = sender.tag - 666
        
        isExpand[section] == false ? (isExpand[section] = true) : (isExpand[section] = false)
        
        self.setTableView!.reloadSections(IndexSet(integer: section), with: .automatic)
    }

    
    //返回主頁
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //底
}
