//
//  ViewController.swift
//  NamozVaqitlariAPI
//
//  Created by Mac on 04/01/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: - Outlets -
    let regionLabel = UILabel()
    let startButton = UIButton()
    let pickerView = UIPickerView()

    
    // text stack view elements
    let textStackView = UIStackView()
    let bomdod = UILabel()
    let quyosh = UILabel()
    let peshin = UILabel()
    let asir = UILabel()
    let shom = UILabel()
    let xufton = UILabel()
    
    // time stack view elements
    let timeStackView = UIStackView()
    let bomdodT = UILabel()
    let quyoshT = UILabel()
    let peshinT = UILabel()
    let asirT = UILabel()
    let shomT = UILabel()
    let xuftonT = UILabel()
    
    var dataModel: DataModel?
    
    var locations = ["Andijon", "Buxoro", "Jizzax", "Xorazm", "Namangan", "Navoiy", "Qashqadaryo", "Samarqand", "Sirdaryo", "Surxondaryo", "Toshkent" ]
    
    let activeIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        fetchData(region: "andijon")
        view.backgroundColor = .systemGreen
    }
    
    //MARK: - initView -
    func initView() {
        
        view.addSubview(regionLabel)
        regionLabel.text = "Namoz Vaqitlari  Andijon"
        regionLabel.textAlignment = .center
        regionLabel.textColor = .white
        regionLabel.font = .boldSystemFont(ofSize: 35)
        regionLabel.numberOfLines = .max
        regionLabel.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(50)
            make.height.equalTo(view.snp.height).multipliedBy(0.17)
        }
        
        bomdod.text = "Bomdod"
        bomdod.textColor = .white
        bomdod.font = .boldSystemFont(ofSize: 25)
        
        quyosh.text = "Quyosh"
        quyosh.textColor = .white
        quyosh.font = .boldSystemFont(ofSize: 25)
        
        peshin.text = "Peshin"
        peshin.textColor = .white
        peshin.font = .boldSystemFont(ofSize: 25)
        
        asir.text = "Asir"
        asir.textColor = .white
        asir.font = .boldSystemFont(ofSize: 25)
        
        shom.text = "Shom"
        shom.textColor = .white
        shom.font = .boldSystemFont(ofSize: 25)
        
        xufton.text = "Xufton"
        xufton.textColor = .white
        xufton.font = .boldSystemFont(ofSize: 25)
        
        view.addSubview(textStackView)
        textStackView.backgroundColor = .systemGreen
        textStackView.alignment = .fill
        textStackView.axis = NSLayoutConstraint.Axis.vertical
        textStackView.distribution = UIStackView.Distribution.equalSpacing
        textStackView.alignment = UIStackView.Alignment.fill
        textStackView.spacing = 15.0
        textStackView.addArrangedSubview(bomdod)
        textStackView.addArrangedSubview(quyosh)
        textStackView.addArrangedSubview(peshin)
        textStackView.addArrangedSubview(asir)
        textStackView.addArrangedSubview(shom)
        textStackView.addArrangedSubview(xufton)
        textStackView.snp.makeConstraints{ make in
            make.left.equalTo(view.snp.left).offset(50)
            make.right.equalTo(view.snp.centerX).offset(-20)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
            make.top.equalTo(regionLabel.snp.bottom).offset(30)
        }
        
        bomdodT.text = "⏰"
        bomdodT.textColor = .white
        bomdodT.font = .boldSystemFont(ofSize: 30)
        
        quyoshT.text = "⏰"
        quyoshT.textColor = .white
        quyoshT.font = .boldSystemFont(ofSize: 30)
        
        peshinT.text = "⏰"
        peshinT.textColor = .white
        peshinT.font = .boldSystemFont(ofSize: 30)
        
        asirT.text = "⏰"
        asirT.textColor = .white
        asirT.font = .boldSystemFont(ofSize: 30)
        
        shomT.text = "⏰"
        shomT.textColor = .white
        shomT.font = .boldSystemFont(ofSize: 30)
        
        xuftonT.text = "⏰"
        xuftonT.textColor = .white
        xuftonT.font = .boldSystemFont(ofSize: 30)
        
        view.addSubview(timeStackView)
        timeStackView.backgroundColor = .systemGreen
        timeStackView.alignment = .fill
        timeStackView.axis = NSLayoutConstraint.Axis.vertical
        timeStackView.distribution = UIStackView.Distribution.equalSpacing
        timeStackView.alignment = UIStackView.Alignment.fill
        timeStackView.spacing = 15.0
        timeStackView.addArrangedSubview(bomdodT)
        timeStackView.addArrangedSubview(quyoshT)
        timeStackView.addArrangedSubview(peshinT)
        timeStackView.addArrangedSubview(asirT)
        timeStackView.addArrangedSubview(shomT)
        timeStackView.addArrangedSubview(xuftonT)
        timeStackView.snp.makeConstraints{ make in
            make.right.equalTo(view.snp.right).offset(-30)
            make.left.equalTo(view.snp.centerX)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
            make.top.equalTo(regionLabel.snp.bottom).offset(30)
        }
        
        view.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(timeStackView.snp.bottom)
            make.bottom.equalTo(view.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.snp.width)
        }
        
        view.addSubview(activeIndicator)
        activeIndicator.startAnimating()
        activeIndicator.isHidden = false
        activeIndicator.style = .large
        activeIndicator.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.2)
            make.width.equalTo(view.snp.width).multipliedBy(0.2)
        }
    }
    
    //MARK: - fetchData -
    func fetchData(region: String) {
        
        // url
        let regionL = region.lowercased()

        let url = URL(string: "https://www.azamjondev.deect.ru/namozvaqtlari/index.php?region=" + "\(regionL)")

        // dataTask

        let dataTask = URLSession.shared.dataTask(with: url!) { (data , res , error) in

            guard let data = data , error == nil else {

                print("Error is \(String(describing: error))")
                return
            }
            var cList: DataModel?

            do {
                cList = try JSONDecoder().decode(DataModel.self, from: data)
                print(data)
            }
            catch _{
                
            }
            
            guard let result = cList else {
                print("oo nima gap")
                return
            }
            
            let status = result.status
            let dataD = result.date
            let weekday = result.weekdate
            let resultD = result.result
           
            print(dataD)
            
            self.dataModel = DataModel(status: status, date: dataD, weekdate: weekday, result: resultD)
            DispatchQueue.main.async {
                
                guard let finalData = self.dataModel else {
                    print("Error is here")
                    return
                }
                
                self.activeIndicator.stopAnimating()
                self.activeIndicator.isHidden = true
                
                self.bomdodT.text = "⏰   \(finalData.result.tong_saharlik)"
                self.quyoshT.text = "⏰   \(finalData.result.quyosh)"
                self.peshinT.text = "⏰   \(finalData.result.peshin)"
                self.asirT.text = "⏰   \(finalData.result.asr)"
                self.shomT.text = "⏰   \(finalData.result.shom_iftor)"
                self.xuftonT.text = "⏰   \(finalData.result.xufton)"
            }
        }
        dataTask.resume()
    }
}

//MARK: - PickerView Delegate DataSourse -
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return locations.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return locations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        for i in 0...10 {
           
            if i == row {
                fetchData(region: locations[row])
                regionLabel.text = "Namoz Vaqitlari \(locations[row])"
            }
        }
        
//        switch row {
//        case 0:
//            fetchData(region: locations[row])
//            putTheData()
//            initView()
//        default:
//            print("Default")
//        }
    }
    
}
