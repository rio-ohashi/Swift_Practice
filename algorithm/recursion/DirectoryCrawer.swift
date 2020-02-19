import Foundation

func passingtoarray(path:String, depth: Int=0) -> (Int,Int){
    var numFile = 0
    var numDir = 0
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
            
            var isDir = ObjCBool(false)
            let child = "\(path)/\(file)"
            if fileManager.fileExists(atPath: child, isDirectory: &isDir) {
                if isDir.boolValue {
                    let (f,d) = passingtoarray(path:child, depth: depth + 1)
                    numFile += f
                    numDir += d
                    numDir += 1
                }
                else {
                    numFile += 1
                }
            }
        }
    } catch {
        print("Enter valid path!!")
    }
    return (numFile, numDir)
}
