//
//  HomeVC.swift
//  Practical_Test_Theta
//
//  Created by hyperlink on 08/02/22.
//

import UIKit
import SwiftyJSON
import Alamofire

class HomeVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    
    class HomeData{
        var name : String = ""
        var age : String = ""
        var email : String = ""
    }
    var arrHomeData = [HomeData]()
    typealias Success = (_ responseData: Any, _ success: Bool) -> Void
    typealias Failure = () -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tblView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.tabBarController?.tabBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.tabBarController?.tabBar.shadowImage = UIImage()
        self.navigationController?.tabBarController?.tabBar.isTranslucent = false
        self.navigationController?.tabBarController?.tabBar.backgroundColor = .systemBrown
//        self.navigationController?.navigationBar.isTranslucent = true
    
        call_GetAPI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.hidesBackButton = true
      
    }
}

extension HomeVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHomeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        let dict = arrHomeData[indexPath.row]
        
        if dict.email.starts(with: "@"){
            dict.email.removeFirst()
        }
        if dict.name.starts(with: "@"){
            dict.name.removeFirst()
        }
        cell.lblName.text = dict.name
        cell.lblAge.text = dict.age
        cell.lblEmail.text = dict.email
        return cell
    }
    
    
}


//MARK:- API Callback Methods
extension HomeVC{
    func call_GetAPI(){
        
        self.GET(filePath: "http://139.162.53.200:3000/?child=false", params: nil, enableInteraction: false, showLoader: true, viewObj: self.view, onSuccess: { (result, success) in
            
            let Dict = JSON(result).arrayValue
           
                for i in 0...Dict.count - 1{
                    let obj = HomeData()
                    obj.name = JSON(Dict[i]["name"]).stringValue
                    obj.age = JSON(Dict[i]["age"]).stringValue
                    obj.email = JSON(Dict[i]["email"]).stringValue
                    self.arrHomeData.append(obj)
                }
            print(self.arrHomeData)
            self.tblView.reloadData()
        }, onFailure: {
        })
    }
}

//MARK:- API Get Method
extension HomeVC{
    func GET(filePath: String, params: [String: Any]?, enableInteraction: Bool, showLoader: Bool, viewObj: UIView?, onSuccess: @escaping (Success), onFailure: @escaping (Failure)) {
        
        guard NetworkReachabilityManager()!.isReachable else {
            return
        }
        let strPath = filePath
        var viewSpinner: UIView?
        if (showLoader) {
            viewSpinner = IPLoader.showLoaderWithBG(viewObj: viewObj!, boolShow: showLoader, enableInteraction: enableInteraction)!
        }
        var headers : HTTPHeaders = []
        headers = []
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        manager.request(strPath, method: .get, parameters: params, encoding: URLEncoding() as ParameterEncoding,headers: headers).responseJSON { (response:AFDataResponse<Any>) in
            
            if (showLoader) {
                IPLoader.hideRemoveLoaderFromView(removableView: viewSpinner!, mainView: viewObj!)
            }
            onSuccess(response.value, true)
            print(response)
//            switch response.result{
//            case .success(let value):
//                if let dictResponse =  value  as? [String:Any] {
//                    if let msg = dictResponse["status"] as? String, msg == "401" || msg == "500" {
//                        onFailure()
//                    }else{
//                        onSuccess(dictResponse, true)
//                        print(dictResponse)
////                        if let strCode = dictResponse["status"] as? Int , strCode == 1 || strCode == 200 {
////                            onSuccess(dictResponse, true)
////                            print(dictResponse)
////                        }else if let str = dictResponse["code"] as? Int, str == 403 {
////                            AJAlertController.initialization().showAlertWithOkButton(aStrMessage: dictResponse["message"] as? String ?? "Your session has expired. Please log in again.") { (index, title) in
////
////                            }
////                        }else if "\(dictResponse["code"] ?? "")" == "403" {
////                            AJAlertController.initialization().showAlertWithOkButton(aStrMessage: dictResponse["message"] as? String ?? "Your session has expired. Please log in again.") { (index, title) in
////                            }
////                        }
////                        else{
////                            if dictResponse["error"] != nil{
////                                if let dictError = dictResponse["error"] as? [String : Any]{
////
////                                }
////                            }
////                            else{
////                                onFailure()
////                            }
////                        }
//                    }
//                }
//            case .failure(let error):
//                if error._code == NSURLErrorBadURL || error._code == NSURLErrorUnsupportedURL || error._code == NSURLErrorCannotFindHost || error._code == NSURLErrorCannotConnectToHost || error._code == NSURLErrorBadServerResponse {
//
//                }
//                else if error._code == NSURLErrorTimedOut {
//                }
//                else if error._code == NSURLErrorNetworkConnectionLost || error._code == NSURLErrorNotConnectedToInternet{
//                }
//                else if error._code == NSURLErrorSecureConnectionFailed{
//                }
//                else if error._code == NSURLErrorFileDoesNotExist{
//                }
//                else {
//                }
//                print("Error:- \(String(describing: error.localizedDescription))")
//                onFailure()
//                break
//            default:
//                break
//            }
        }
    }
}
