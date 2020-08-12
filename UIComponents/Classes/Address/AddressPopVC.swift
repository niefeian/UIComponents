//
//  AddressPopVC.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/5/2.
//

import UIKit
import SwiftProjects
import SnapKit
import NFAToolkit
import AutoModel

public class Zone: BaseModel {
    @objc public var zoneId = 0
    @objc public var zoneName = ""
    
    @objc var rank = -1
    @objc var letter = ""
    @objc public var upwardZone : Zone!
    @objc public var nextZones : [Zone]! = [Zone]()
    
    public func getZoneName() -> String{
        if self.upwardZone != nil && self.upwardZone.zoneName != ""{
            return  self.upwardZone.getZoneName() + "," + self.zoneName
        }else{
            return self.zoneName
        }
    }
    
    public func getZoneId() -> String{
        if self.upwardZone != nil && self.upwardZone.zoneId != 0{
            return  self.upwardZone.getZoneId() + "," + "\(self.zoneId)"
        }else{
            return  "\(self.zoneId)"
        }
    }
}


public protocol ZoneDelegate : NSObjectProtocol {
    
    func getZone(_ rank : Int , zoneId : Int , cb : @escaping ([Zone]) -> Void)
    func setZone(_ zone:Zone)
    
}

//getZone

public class AddressPopVC: BasePopVC {

    var tips = UILabel()
    var tableView = UITableView()
    public weak var delegate : ZoneDelegate!
    var seleZone : Zone!  = Zone()
//    var nextZones = [Zone]()
    override public func viewDidLoad() {
        super.viewDidLoad()
        regisPopSize(CGSize(width: AppWidth, height: AppHeight*0.85))
       
        delegate.getZone(0, zoneId: 0) { (zones) in
            self.seleZone.nextZones = zones
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    override public func initializePage() {
        self.view.addSubview(tips)
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
           
        self.view.addSubview(tableView)
    }
    override public func initLayoutSubviews() {
        tips.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(5)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        tableView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(tips.snp.bottom).offset(0)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    override public func initializeDelegate() {
        tableView.delegate =  self
        tableView.dataSource = self
        tableView.register(AddressCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SpeedCell.self, forCellReuseIdentifier: "speed")
    }

    public override func initializeDraw() {
        tips.backgroundColor = .white
        tips.textAlignment = .center
        tips.text = "请选择"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension AddressPopVC : UITableViewDelegate,UITableViewDataSource{
    
   public func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    
   public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return -1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let i = self.seleZone.upwardZone != nil ? 2 : 1
        return self.seleZone.nextZones.count + i
       
    }
    
    
   public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
     let i = self.seleZone.upwardZone != nil  ? 2 : 1
    if i == 2 && indexPath.row == 0 {
         let cell = tableView.dequeueReusableCell(withIdentifier: "speed") as! SpeedCell
        cell.speeds = getZoneName(seleZone).components(separatedBy: ",")
        return cell
    }
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AddressCell
    let lable1 =  cell.getSubview(autoViewClass: .label, index: 1) as? UILabel
    let lable2 =  cell.getSubview(autoViewClass: .label, index: 2) as? UILabel
    lable1?.isHidden = false
    lable2?.isHidden = false
   
        if indexPath.row == i - 1 {
            lable2?.isHidden = true
            switch seleZone.rank {
            case -1:  lable1?.text = "请选择省份地区"
                case 0:lable1?.text = "请选择城市"
                case 1:lable1?.text = "请选择区/县"
            default:
                break
            }
              return cell
        }
        if seleZone.nextZones.count < indexPath.row-i{
            return cell
        }
        let model = seleZone.nextZones[indexPath.row-i]
        if indexPath.row > i + 1 {
             let model2 = seleZone.nextZones[indexPath.row - i - 1]
            lable1?.isHidden = model.letter == model2.letter
        }
        lable1?.text = model.letter
        lable2?.text = model.zoneName
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let i = self.seleZone.upwardZone != nil ? 2 : 1
        if indexPath.row < i {
            return
        }
       
        if let model = seleZone?.nextZones[indexPath.row - i] {
            model.upwardZone = seleZone
            seleZone = model
            delegate.getZone(seleZone.rank + 1, zoneId: seleZone.zoneId) { (array) in
                self.delegate.setZone(self.seleZone)
                if array.count == 0 {
                    self.disappear?()
                }else{
                    self.seleZone.nextZones = array
                    tableView.reloadData()
                }
            }
        }
       
    }
    
    func getZoneName(_ model : Zone) -> String{
        if model.upwardZone != nil && model.upwardZone.zoneName != ""{
            return  getZoneName(model.upwardZone) + "," + model.zoneName
        }else{
            return model.zoneName
        }
    }
 
}


