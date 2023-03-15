
Instance: Dr-hello-world
InstanceOf: DocumentReference
Title: "Binary example using DocumentReference"
Description: "Example of a hello world binary using DocumentReference."
* status = #current
* content.attachment.id = "ig-loader-helloWorld.txt"
//* content.attachment.url = "Binary/B-hello-world"
* content.attachment.contentType = #text/plain


// binary throws a File Type error that DocumentReference does not
// likely needs a IG extension - implementationguide-resource-format
Instance: B-hello-world
InstanceOf: Binary
Title: "Binary example using Binary of text"
Description: "Example of a binary hello world using Binary."
* contentType = #text/plain
* data = "ig-loader-helloWorld.txt"

// binary throws a File Type error that DocumentReference does not
// likely needs a IG extension - implementationguide-resource-format
Instance: B-ink
InstanceOf: Binary
Title: "Binary example using Binary of png"
Description: "Example of a binary ink signature using Binary."
* contentType = #image/png
* data = "ig-loader-ink.png"
