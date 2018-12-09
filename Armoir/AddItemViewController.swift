//
//  AddItemViewController.swift
//  Armoir
//
//  Created by alex weitzman on 12/4/18.
//  Copyright © 2018 CS147. All rights reserved.
//

import UIKit
import DropDown

let sizeDropDown:DropDown = DropDown()
let categoryDropDown2:DropDown = DropDown()
var itemCategory:String = String()
var itemSize:String = String()

class AddItemViewController: UIViewController {

    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var Description: UITextField!
    
    @IBOutlet weak var Price: UITextField!
    
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var sizeButton: UIButton!

    
    @IBAction func sizeClicked(_ sender: Any) {
        sizeDropDown.show()
    }
    
    @IBAction func categoryClicked(_ sender: Any) {
        categoryDropDown2.show()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        //let description: String = Description.text!
        //needs to be a double based on what they enter
        var imageURL = "jeanJacketFinal"
        if (!startWithCamera) {
            imageURL = ImageRetriever().load(fileName: "SavedImage" + String(numImgSaved))
        }
        if (imageURL != "") { /* add it to JSON*/ }
        print(imageURL)
        let price = 3.0
        //let description = ""
        var numItems = 0
        let category = "shirt"
        for u in all_users {
            for i in u.closet {
                numItems += 1
            }
        }
        let new_item = Item(item_id: numItems+1, name: "Jean Jacket", owner: currUser.user_ID, borrowed: false, borrowed_by: 0, image: "jeanJacketFinal", color: "red", size: "M", price: price, category: category)
        
        /*let new_item = Item(item_id: numItems+1, name: description, owner: currUser.user_ID, borrowed: false, borrowed_by: 0, image: imageURL, color: color, size: "S", price: price, category: "shirt")*/
        
        for var u in all_users {
            if (u.user_ID == currUser.user_ID) {
                u.closet.append(new_item)
            }
        }
        
        //currUser.closet.append(new_item)
        numImgSaved += 1
        
        if (startWithCamera) {
            print("true")
            // Go back two ViewControllers
            _ = navigationController?.popViewControllers(viewsToPop: 2)
        } else {
            _ = navigationController?.popViewControllers(viewsToPop: 1)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let icon = UIImage(named: "downarrow3")!
        categoryButton.setImage(icon, for: .normal)
        categoryButton.imageView?.contentMode = .scaleAspectFit
        categoryButton.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        categoryButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: categoryButton.frame.size.width - categoryButton.titleLabel!.intrinsicContentSize.width, bottom: 0, right: 0)
        sizeButton.setImage(icon, for: .normal)
        sizeButton.imageView?.contentMode = .scaleAspectFit
        sizeButton.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        sizeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: sizeButton.frame.size.width - sizeButton.titleLabel!.intrinsicContentSize.width, bottom: 0, right: 0)
        itemCategory = ""
        itemSize = ""
        
        initDropDowns()
        initcategoryDropDown2()
        initSizeDropDown()
        
        itemImageView.image = itemImage
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        self.navigationItem.hidesBackButton = false;
        
    }
    
    func initDropDowns() {
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().textFont = UIFont(name: "Alike-Regular", size: 17)!
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().cellHeight = 40
        
        categoryDropDown2.anchorView = categoryButton
        sizeDropDown.anchorView = sizeButton
        
        categoryDropDown2.direction = .bottom
        sizeDropDown.direction = .bottom
        
        categoryDropDown2.dismissMode = .automatic
        sizeDropDown.dismissMode = .automatic
        
        categoryDropDown2.bottomOffset = CGPoint(x: 0, y:(categoryDropDown2.anchorView?.plainView.bounds.height)!)
        sizeDropDown.bottomOffset = CGPoint(x: 0, y:(sizeDropDown.anchorView?.plainView.bounds.height)!)
    }
    
    func initcategoryDropDown2() {
        let categories = ["Shirt", "Pants", "Skirt", "Shorts", "Dress"]
        categoryDropDown2.dataSource = categories
        
        categoryDropDown2.selectionAction = { [weak self] (index: Int, _: String) in
            itemCategory = categories[index]
            self?.categoryButton.setTitle(categories[index],for: .normal)
            print(itemCategory)
        }
    }
    
    func initSizeDropDown() {
        let sizes = ["XS", "S", "M", "L", "XL"]
        sizeDropDown.dataSource = sizes
        
        sizeDropDown.selectionAction = { [weak self] (index: Int, _: String) in
            itemSize = sizes[index]
            self?.sizeButton.setTitle(sizes[index],for: .normal)
            print(itemSize)
        }
    }
    
    @objc func back(sender: UIBarButtonItem) {
        if (startWithCamera) {
            print("true")
        // Go back two ViewControllers
            _ = navigationController?.popViewControllers(viewsToPop: 2)
        } else {
            _ = navigationController?.popViewControllers(viewsToPop: 1)
        }
        
    }

}

extension UINavigationController {
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
    
    func popViewControllers(viewsToPop: Int, animated: Bool = true) {
        if viewControllers.count > viewsToPop {
            let vc = viewControllers[viewControllers.count - viewsToPop - 1]
            popToViewController(vc, animated: animated)
        }
    }
    
}
