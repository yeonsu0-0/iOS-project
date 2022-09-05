//
//  Storage.swift
//  TodoList
//
//  Created by yeonsu on 8/21/22.
//

import Foundation

// 사용자에 의해 생성되는 모든 컨텐츠들은 Documents directory에 저장

//  💡 제일 먼저 할 일: Document Directory가 어디에 있는지 URL을 얻기 위한 코드


public class Storage {
    
    private init() {}
    
    // TODO: directory 설명
    // TODO: FileManager 설명
    
    enum Directory {
        case documents
        case caches
        
        // 📌 ====
        // url은 computed property
        // Directory의 종류에 따라 FileManager.SearchPathDirectory의 타입을 갖는 path의 값을 변경
        var url: URL {
            let path: FileManager.SearchPathDirectory
            switch self {
            case .documents:
                path = .documentDirectory
            default:
                path = .cachesDirectory
            }
            
            // default는 FileManager의 Singleton instance를 만들어주는 것
            
            // 📌 urls 메서드
            // 요청된 도메인에서 지정된 공통 디렉토리에 대한 URL 배열을 리턴해주는 메서드
            
            // 매개변수 for: 검색 경로 디렉토리
            // 매개변수 in: 도메인
            return FileManager.default.urls(for: path, in: .userDomainMask).first!
        }
    }
    
    
    // appendingPathComponent(): 가져온 DocumentURL에 매개변수로 받은 path component를 추가한 것을 URL로 반환하는 메서드
    // 파일을 쓰게되는 path(경로, 위치)를 의미
    
    // JSONEncoder 생성 -> encode 함수에 Todo 데이터를 넣어 현재 파일이 존재하는지 확인
    // 파일이 존재하면 지워버리고 다시 생성
    
    static func store<T: Encodable>(_ obj: T, to directory: Directory, as fileName: String){
        let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
        print("---> save to here: \(url)")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(obj)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch let error {
            print("---> Failed to store msg: \(error.localizedDescription)")
        }
    }
    
    // TODO: 파일은 Data 타입형태로 읽을수 있음
    // TODO: Data 타입은 Codable decode 가능
    
    static func retrive<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T? {
        let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        guard let data = FileManager.default.contents(atPath: url.path) else { return nil }
        
        let decoder = JSONDecoder()
        
        do {
            let model = try decoder.decode(type, from: data)
            return model
        } catch let error {
            print("---> Failed to decode msg: \(error.localizedDescription)")
            return nil
        }
    }
    
    static func remove(_ fileName: String, from directory: Directory) {
        let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            try FileManager.default.removeItem(at: url)
        } catch let error {
            print("---> Failed to remove msg: \(error.localizedDescription)")
        }
    }
    
    static func clear(_ directory: Directory) {
        let url = directory.url
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for content in contents {
                try FileManager.default.removeItem(at: content)
            }
        } catch {
            print("---> Failed to clear directory ms: \(error.localizedDescription)")
        }
    }
}

// MARK: TEST 용
extension Storage {
    static func saveTodo(_ obj: Todo, fileName: String) {
        let url = Directory.documents.url.appendingPathComponent(fileName, isDirectory: false)
        print("---> [TEST] save to here: \(url)")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
         
        do {
            let data = try encoder.encode(obj)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch let error {
            print("---> Failed to store msg: \(error.localizedDescription)")
        }
    }

    
    
    static func restoreTodo(_ fileName: String) -> Todo? {
        let url = Directory.documents.url.appendingPathComponent(fileName, isDirectory: false)
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        guard let data = FileManager.default.contents(atPath: url.path) else { return nil }
        
        let decoder = JSONDecoder()
        
        do {
            let model = try decoder.decode(Todo.self, from: data)
            return model
        } catch let error {
            print("---> Failed to decode msg: \(error.localizedDescription)")
            return nil
        }
    }
}

