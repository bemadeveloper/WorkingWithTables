//
//  ViewController.swift
//  WorkingWithTables
//
//  Created by Bema on 25/2/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var names = ["John", "Dima", "Nikita", "Alexey", "Sonya", "Anna", "Elena", "Alexander", "Ivan", "Petr"]
    private var images = [UIImage(systemName: "globe.americas"), UIImage(systemName: "sun.min"), UIImage(systemName: "figure.walk"), UIImage(systemName: "sunset"), UIImage(systemName: "house"), UIImage(systemName: "network"), UIImage(systemName: "seal"), UIImage(systemName: "location"), UIImage(systemName: "pencil"), UIImage(systemName: "bubble")]
    
    // MARK: - Outlets
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        
        return tableView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 20
        textField.textAlignment = .center
        textField.placeholder = "Type name here..."
        textField.resignFirstResponder()
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.setTitle("Press to add", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    
    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
    }

    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(textField)
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    private func setupLayout() {
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
            make.left.equalTo(view).offset(20)
            make.height.equalTo(40)
            
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.left.equalTo(view).offset(20)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(20)
            make.right.bottom.left.equalTo(view)
        }
        
    }
    
    private func setupView() {
        view.backgroundColor = .systemYellow
        tableView.reloadData()
        
        title = "TableView"
        navigationController?.navigationBar.prefersLargeTitles = true
        textField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    @objc
    private func buttonPressed() {
        if textField.text != "" {
            names.append(textField.text ?? "")
            print(names.count)
        } else {
            let alert = UIAlertController(
                title: "Nothing was written", 
                message: "Pllease enter the name",
                preferredStyle: .alert)
                
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        cell.imageView?.image = images[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            names.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

