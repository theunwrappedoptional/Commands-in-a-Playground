//Import Cocoa to access Process (former NSTask)
import Cocoa

//Create a new Process
 let process = Process()

//Set the executable URL for the process to a file URL path discovered
// To discover the command path run "which 'COMMAND'" in Terminal (e.g. "which whoami")
process.executableURL = URL(filePath: "/sbin/ping")

//Provide the arguments to the process
// To discover the arguments list run "'COMMAND' man" in Terminal (e.g. "man whoami")

process.arguments = ["-c", "5", "apple.com"]

//Create a picpe to enable communications between process
let outPipe = Pipe()

//Setup a File Handle to read the data coming through the pipe
let outFile = outPipe.fileHandleForReading

//Assign the pipe as the standard output for the process
process.standardOutput = outPipe

do{
    try process.run()
    process.waitUntilExit()
    
    if let data = try outFile.readToEnd(),
       let returnValue = String(data: data, encoding: .utf8) {
        print("Result: \(returnValue)")
    }
} catch{
    print(error)
}
