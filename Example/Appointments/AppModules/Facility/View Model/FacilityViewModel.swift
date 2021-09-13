// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import SwiftyJSON



protocol FacilityViewModelOutputs {
    var facilitiesObservable : Observable<[Facility]>{get}
}

protocol FacilityViewModelType {
    var outputs: FacilityViewModelOutputs { get }
}

class FacilityViewModel : FacilityViewModelType,FacilityViewModelOutputs{
        
    var outputs: FacilityViewModelOutputs { return self }

    //Mark:- Outputs
    var facilitiesObservable: Observable<[Facility]>{ return facilities.asObservable()}
    
    //Mark:- Private Properties
    private var disposeBag = DisposeBag()
    private var facilities = BehaviorSubject<[Facility]>(value: [Facility]())

    init() {
        bindFacilities()
        getFacilities()
    }
    
    func getFacilities(){
        ApiManager.getRequest(with: APPURL.Facility, parameters: nil, completion: { (result) in
            Functions.hideActivity()
            switch result {
            case .success(let result):
                let json = JSON(result.value as Any)
                print(json)
                Functions.saveJSON(json: json, key: "facilities")
                self.bindFacilities()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func bindFacilities(){
        let newJson = Functions.getJSON("facilities")
        if newJson == nil{
            Functions.showActivity()
        }else{
            self.facilities.onNext(
                intializeModel(with: newJson ?? JSON())
            )
        }
    }
    
    func intializeModel(with result: JSON) -> [Facility]{
        var facilities = [Facility]()
        for facility in result["facilities"].arrayValue{
            facilities.append(Facility(fromJson: facility))
        }
        return facilities
    }
    
}

