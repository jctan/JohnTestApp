//
//  ViewController.swift
//  johntest
//
//  Created by John Tan on 3/10/20.
//  Copyright © 2020 John Tan. All rights reserved.
//

import UIKit
import Branch

class ViewController: UIViewController {

    @IBOutlet weak var urlText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func createLink(_ sender: Any) {
        
        let buo = BranchUniversalObject.init(canonicalIdentifier: "content/12345")
        buo.title = "Create Link"
        buo.contentDescription = "Create Link from Android SDK"
        buo.publiclyIndex = true
        buo.locallyIndex = true
        buo.contentMetadata.customMetadata["link"] = "link1"
        
        let lp: BranchLinkProperties = BranchLinkProperties()
        lp.channel = "facebook"
        lp.feature = "sharing"
        lp.campaign = "Content 123 Campaign"
        lp.stage = "New User"
        lp.addControlParam("$desktop_url", withValue: "http://github.com")
        lp.addControlParam("fallback_url", withValue: "http://github.com/jctan")
        lp.addControlParam("$deeplink_path", withValue: "johnItem")
        lp.addControlParam("face", withValue: "round")
        lp.addControlParam("name", withValue: "john")
        lp.addControlParam("body", withValue: "skinny")
        lp.addControlParam("color", withValue: "dark")
        
        buo.getShortUrl(with: lp) { (url, error) in
            //print(url ?? "")
            DispatchQueue.main.async {
                self.urlText.text = String(url ?? "")
            }
        }
    }
    
    @IBAction func trackCommerceEvents(_ sender: Any) {
        
        let buo = BranchUniversalObject.init(canonicalIdentifier: "content/1234")
        buo.canonicalUrl = "htps://testCanonicalUrl.com"
        buo.title = "Test_Commerce_Title"
        buo.contentMetadata.customMetadata["custom_metadata_key1"] = "custom_metadata_val1"
        buo.contentMetadata.imageCaptions = ["image_caption_1","image_caption2","image_caption3"]
        buo.contentMetadata.addressStreet = "28 Liberty St"
        buo.contentMetadata.addressCity = "New York"
        buo.contentMetadata.addressRegion = "NY"
        buo.contentMetadata.addressCountry = "USA"
        buo.contentMetadata.addressPostalCode = "11214"
        buo.contentMetadata.ratingAverage = 5.2
        buo.contentMetadata.ratingMax = 6.0
        buo.contentMetadata.ratingCount = 5
        buo.contentMetadata.latitude = -151.67
        buo.contentMetadata.longitude = -124.0
        buo.contentMetadata.price = 10.0
        buo.contentMetadata.currency = .USD
        buo.contentMetadata.productBrand = "Test_Prod_Brand"
        buo.contentMetadata.productCategory = BNCProductCategory.apparel
        buo.contentMetadata.productName = "Test_Prod_Name"
        buo.contentMetadata.condition = BranchCondition.excellent
        buo.contentMetadata.productVariant = "Test_Prod_Variant"
        buo.contentMetadata.quantity = 1.5
        buo.contentMetadata.sku = "test_sku"
        buo.contentMetadata.contentSchema = BranchContentSchema.commerceProduct
        
        let purchaseEvent = BranchEvent.standardEvent(.purchase)
        purchaseEvent.contentItems = [buo]
        purchaseEvent.currency = .USD
        purchaseEvent.transactionID = "order_id_1231231"
        purchaseEvent.revenue = 10
        purchaseEvent.customData = [
            "payment": "creditcard"
        ]
        purchaseEvent.logEvent()
        print(purchaseEvent)
        
        let viewItemEvent = BranchEvent.standardEvent(.viewItem)
        viewItemEvent.contentItems = [buo]
        viewItemEvent.currency = .USD
        viewItemEvent.revenue = 10
        viewItemEvent.customData = [
            "type": "user"
        ]
        viewItemEvent.logEvent()
        
        let viewItemsEvent = BranchEvent.standardEvent(.viewItems)
        viewItemsEvent.contentItems = [buo]
        viewItemsEvent.customData = [
            "type": "user"
        ]
        viewItemsEvent.logEvent()
        
        let completeRegistrationEvent = BranchEvent.standardEvent(.completeRegistration)
        completeRegistrationEvent.alias = "registration_alias"
        completeRegistrationEvent.transactionID = "tx1234"
        completeRegistrationEvent.eventDescription = "John created an Account"
        completeRegistrationEvent.customData = [
            "registrationID": "john12345"
        ]
        completeRegistrationEvent.logEvent()
        
        let johnTestEvent = BranchEvent.customEvent(withName: "JOHN_TEST")
        johnTestEvent.contentItems = [buo]
        johnTestEvent.customData = [
            "user": "johntest"
        ]
        johnTestEvent.logEvent()
        
    }
    
    @IBAction func shareButton(_ sender: Any) {
        
        let buo = BranchUniversalObject.init(canonicalIdentifier: "sharecontent/12345")
        buo.title = "My Content Title"
        buo.contentDescription = "My Content Description"
        buo.imageUrl = "https://loremixel.com/400/400"
        
        let lp: BranchLinkProperties = BranchLinkProperties()
        lp.feature = "Sharing"
        lp.campaign = "Content 123 launch"
        lp.stage = "new user"
        lp.addControlParam("$desktop_url", withValue: "http;//branch.io/home")
        lp.addControlParam("$ios_url", withValue: "https://branch.io")
        lp.addControlParam("$match_duration", withValue: "2000")
        lp.addControlParam("$user_identifier", withValue: "user_123")
        
        
        let message = "Check out this link"
        buo.showShareSheet(with: lp, andShareText: message, from: self) { (activityType, completed) in
            print(activityType ?? "")
            NSLog("Done showing share sheet!")
        }
        
        
    }

}

