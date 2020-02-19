import Foundation

func passingtoarray(path:String, depth: Int){
    let sourcePath = URL(fileURLWithPath: path, isDirectory: true)
    let fileManager = FileManager.default
    var depthStr:String = ""
    for d in 0...depth {
        if d > 0 {
            depthStr += "|   "
        }
    }
    
    do{
        let files = try fileManager.contentsOfDirectory(atPath: sourcePath.path)
        for (index, file) in files.enumerated() {
            if index != files.endIndex - 1 {
                print(depthStr + "├─"+file)
            } else {
                print(depthStr + "└─"+file)
            }
            do {
                let childPath = path + "/" + file
                let sourcePath = URL(fileURLWithPath: childPath, isDirectory: true)
                let _ = try fileManager.contentsOfDirectory(atPath: sourcePath.path)
                passingtoarray(path:childPath, depth: depth + 1)
            } catch {
            }
        }
    } catch {
        print("Enter valid path!!")
    }
}
