//
//  CreateCompanyController.swift
//  Intermediate
//
//  Created by Lili on 03/07/2019.
//  Copyright © 2019 Lili. All rights reserved.
//

import UIKit
import CoreData
// Custom Delegation
protocol CreateCompanyControllerDelegete {
    func didAddCompany( company: Company)
}

class CreateCompanyController: UIViewController {
    
    // not tightl coupled
    var delegate: CreateCompanyControllerDelegete?
    
    //var companiesController: CompaniesController?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        // enable autolayuot
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let nameTextField: UITextField =  {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    
     }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        navigationItem.title = "Create Company"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        view.backgroundColor = UIColor.darkBlue
        
    }
    
    @objc private func handleSave() {
        print("Trying to save company...")
        
        
       // let persistentContainer = NSPersistentContainer(name: "IntermediateModels")
       //  persistentContainer.loadPersistentStores { (storeDescription, err) in
           //  if let err = err {
              //   fatalError("Loading of store failed: \(err)")
                
          //   }
       //  }
        
         //let context = persistentContainer.viewContext
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(nameTextField.text, forKey: "name")
        
        do {
           try context.save()
            
             // success
            dismiss(animated: true, completion:  {
                self.delegate?.didAddCompany(company: company as! Company)
            })
            
            
        } catch let saveErr {
            print("Failed to save company: ", saveErr)
        }
    }
    
    
    
    private func setupUI() {
        
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightBlueBackgroundView)
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        //nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
      
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo:nameLabel.topAnchor).isActive = true
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
}
