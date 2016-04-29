//
//  CustomPlanView.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 24/03/16.
//  Copyright © 2016 nesh. All rights reserved.
//

import Foundation


class CustomPlanView: UIView {
    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var viewBtn: UIButton!
    
    class func instanceFromNib() -> CustomPlanView {
       
        return UINib(nibName: "CustomPlanView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CustomPlanView
    }
    
}