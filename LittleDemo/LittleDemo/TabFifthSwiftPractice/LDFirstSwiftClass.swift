//
//  LDFirstSwiftClass.swift
//  LittleDemo
//
//  Created by lynn on 2019/1/30.
//  Copyright © 2019 Lynn. All rights reserved.
//

import Foundation

class LDFirstSwiftClass: NSObject {
    
    // MARK: String Test
    let str1 = "This is a constant string."
    var str2 = ""
    // String
    func testAString() -> Void {
        print(str1)
    }
    
    func testVarString() -> Void {
        if str2.isEmpty {
            print("This is a empty string.")
        }
        else {
            print(str2)
        }
        str2 += "This is a variable string."
    }
    
    // 字符串插值
    func countResult(_ aValue:Double, _ bValue:Double) -> Void {
        let message = "\(aValue) * \(aValue) = \(aValue * aValue)"
        print(message)
    }
    
    // Unicode
    func testUnicode(_ _strValue:String) -> Void {
        print("1. original string = "+_strValue)
        print(_strValue.count)
        for character in _strValue {
            print(character)
        }
        
        // UTF-8
        print("\n2. UTF-8")
        print(_strValue.lengthOfBytes(using: String.Encoding.utf8))
        for character in _strValue.utf8 {
            print(character)
        }
        
        // UTF-16
        print("\n3. UTF-16")
        print(_strValue.lengthOfBytes(using: String.Encoding.utf16))
        for character in _strValue.utf16 {
            print(character)
        }
        
        // Unicode 标量 (Unicode Scalars)
        print("\n4. 遍历Unicode 标量 (Unicode Scalars)")
        for character in _strValue.unicodeScalars {
            print(character)
        }
        
        print("\n5. 遍历Unicode 标量 (Unicode Scalars)")
        for character in _strValue.unicodeScalars {
            print(character.value)
        }
        
    }
    
    // MARK: Collection Test
    func printArray(_ array:Array<Any>, _ info:String) -> String {
        // 数组的遍历
        print("\n"+info)
        if array.isEmpty {
            print("This array is empty")
            return ""
        }
        for (index, value) in array.enumerated() {
            print("Item \(String(index + 1)): \(value)")
        }
        var string = ""
        for obj in array {
            string += "\(obj) "
        }
        return string
    }
    
    func printSetCharacter(_ set:Set<Character>, _ info:String) -> String {
        // 数组的遍历
        print("\n"+info)
        if set.isEmpty {
            print("This set is empty")
            return ""
        }
        for (index, value) in set.enumerated() {
            print("Item \(String(index + 1)): \(value)")
        }
        var string = ""
        for obj in set {
            string += "\(obj) "
        }
        return string
    }
    
    func printSetInt(_ set:Set<Int>, _ info:String) -> String {
        // 数组的遍历
        print("\n"+info)
        if set.isEmpty {
            print("This set is empty")
            return ""
        }
        for (index, value) in set.enumerated() {
            print("Item \(String(index + 1)): \(value)")
        }
        var string = ""
        for obj in set {
            string += "\(obj) "
        }
        return string
    }
    
    func printDictionary(_ dict:Dictionary<String, Any>, _ info:String) -> String {
        // 数组的遍历
        print("\n"+info)
        if dict.isEmpty {
            print("This dictionary is empty")
            return ""
        }
        for (key, value) in dict {
            print("Item \(key): \(value)")
        }
        var string = ""
        for obj in dict {
            string += "\(obj) "
        }
        return string
    }
    
    // Array
    func testArray() -> Void {
        
        var array1:Array<Int> = [1,2,3,4]
        array1.append(5)
        array1.insert(0, at: 0)
        array1 += [6, 7, 8]
        array1[4...6] = [0, 0]
        print(self.printArray(array1,"print array1"))
        print("array count = \(array1.count)")
        
        // 创建并且构造一个数组
        print("\n创建并且构造一个数组")
        let array2:[String] = ["a","b","c","d"]
        print(self.printArray(array2,"print array2"))
        print("array2 count = \(array2.count)")
        
        let array3 = [String]()
        if array3.isEmpty {
            print("array3 count = \(array3.count)")
        }
        
        var array4 = [Double](repeating: 1.1, count: 5)
        array4.append(2.2)
        print(self.printArray(array4,"print array4"))
        print("array4 count = \(array4.count)")
        
        let array5:[Double] = [3.3,3.3,3.3]
        print(self.printArray(array5, "print array5"))
        print("array5 count = \(array5.count)")
        
        print(self.printArray(array4+array5, "print array4+array5"))
        print("array4+array5 count = \((array4+array5).count)")
    }
    
    // Set
    func testSet() -> Void {
        var set1 = Set<Character>()
        print("set1 count = \(set1.count)")
        
        set1.insert("a")
        set1.insert("b")
        set1.insert("d")
        set1.insert("e")
        set1.insert("e")
        set1.insert("d")
        print(self.printSetCharacter(set1, "print set1"))
        set1 = []
        print(self.printSetCharacter(set1, "print set1"))
        set1 = ["r","g","d","e","c","a"]
        print(self.printSetCharacter(set1, "print set1"))
        
        // 排序
        print(self.printArray(set1.sorted(), "print set1 sort"))
        
        // 集合操作
        var oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
        print(self.printArray(oddDigits.union(evenDigits).sorted(), "print oddDigits & evenDigits union"))
        print(self.printArray(oddDigits.intersection(evenDigits).sorted(), "print oddDigits & evenDigits intersection"))
        print(self.printSetInt(oddDigits.subtracting(singleDigitPrimeNumbers), "print oddDigits & singleDigitPrimeNumbers subtracting"))
        oddDigits.formSymmetricDifference(singleDigitPrimeNumbers)
        print(self.printSetInt(oddDigits, "print oddDigits & singleDigitPrimeNumbers formSymmetricDifference"))

        // 集合比较
        let oddDigits1: Set = [1, 3, 5, 7, 9]
        let allDigits: Set = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        if oddDigits1 == oddDigits1 {
            print("oddDigits = oddDigits1")
        }
        
        if oddDigits1.isSubset(of: allDigits) {
            print("oddDigits isSubset of allDigits")
        }
        
        if allDigits.isSuperset(of: oddDigits1) {
            print("allDigits.isSuperset(of: oddDigits)")
        }
        
        if oddDigits1.isDisjoint(with: evenDigits) {
            print("oddDigits.isDisjoint(with: evenDigits)")
        }
    }
    
    // 字典
    func testDictionary() -> Void {
        var dict1 = ["2333": "6666", "1": 2] as [String : Any]
        print("dict1 count \(dict1.count).")
        dict1["a"] = "b"
        if let oldValue = dict1.updateValue("8888", forKey: "2333") {
            print("The old value for 2333 was \(oldValue).")
        }
        print(self.printDictionary(dict1, "print dict1"))
        dict1["3"] = 4
        print(self.printDictionary(dict1, "print dict1"))
        dict1["APL"] = nil
        dict1["3"] = nil
        print(self.printDictionary(dict1, "print dict1"))
        
        var dict2 = Dictionary<Int,Any>()
        dict2[1] = "S1"
        dict2[2] = "S2"
        dict2[3] = "S3"
        dict2[4] = "S4"
        dict2[5] = "S5"
    }
    
    // MARK:
    // String
    func learnString() -> Void {
        print("------- String --------")
        self.testAString()
        self.testVarString()
        self.countResult(3.14, 3.14)
        self.testUnicode("Dog!🐶")
    }
    
    // 集合类型 (Collection Types)
    func learnCollectionType() -> Void {
        print("------- Collection --------")
        self.testArray()
        self.testSet()
        self.testDictionary()
    }
    
    func test() {
//        self.learnString()
        self.learnCollectionType()
    }
}

