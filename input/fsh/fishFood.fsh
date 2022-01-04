
Instance: Dr-hello-world
InstanceOf: DocumentReference
Title: "Binary example using DocumentReference"
Description: "Example of a hello world binary using DocumentReference."
* status = #current
* content.attachment.id = "ig-loader-helloWorld.txt"
//* content.attachment.url = "Binary/B-hello-world"
* content.attachment.contentType = #application/xml


// binary throws a File Type error that DocumentReference does not
// likely needs a IG extension - implementationguide-resource-format
Instance: B-hello-world
InstanceOf: Binary
Title: "Binarty example using Binary"
Description: "Example of a binary hello world using Binary."
* contentType = #application/xml
* data = "ig-loader-helloWorld.txt"

