// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol FacilityViewModelOutputs {
    var facilitiesObservable : Observable<[Facilities]>{get}
}

protocol FacilityViewModelType {
    var outputs: FacilityViewModelOutputs { get }
}

class FacilityViewModel : FacilityViewModelType,FacilityViewModelOutputs{
        
    var outputs: FacilityViewModelOutputs { return self }

    //Mark:- Outputs
    var facilitiesObservable: Observable<[Facilities]>{ return facilities.asObservable()}
    
    //Mark:- Private Properties
    private var disposeBag = DisposeBag()
    private var facilities = BehaviorSubject<[Facilities]>(value: [Facilities]())

    init() {
        bindFacilities()
        getFacilities()
    }
    
    func getFacilities(){
        ApiManager.getRequest(with: APPURL.Facility, parameters: nil, completion: { (result) in
            Functions.hideActivity()
            switch result {
            case .success(let result):
                let newjson = try? JSONSerialization.data(withJSONObject: result.value as Any, options: .prettyPrinted)
                Functions.saveJSON(json: newjson ?? Data(), key: "facilities")
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
                intializeModel(with: newJson! as Data)
            )
        }
    }
    
    func intializeModel(with result: Data) -> [Facilities]{
        let jsonDecoder = JSONDecoder()
        let responseModel = try? jsonDecoder.decode(FacilitiesModel.self, from: result)
        return responseModel?.facilities ?? []
    }
    
}

