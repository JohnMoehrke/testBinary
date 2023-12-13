
Profile:        DocumentReferenceFoo
Parent:         DocumentReference
Title:          "Just a simple profile of DocumentReference"
Description:    "not much to say"
* status = #current
* content.attachment.contentType 1..1


Instance: Dr-hello-world
InstanceOf: DocumentReferenceFoo
Title: "Binary example using DocumentReference"
Description: "Example of a hello world binary using DocumentReference."
* status = #current
* content.attachment.id = "ig-loader-hello-world.txt"
//* content.attachment.url = "Binary/B-hello-world"
* content.attachment.contentType = #text/plain


// binary throws a File Type error that DocumentReference does not
// likely needs a IG extension - implementationguide-resource-format
Instance: B-hello-world
InstanceOf: Binary
Title: "Binary example using Binary of text"
Description: "Example of a binary hello world using Binary."
* contentType = #text/plain
* data = "ig-loader-hello-world.txt"

// binary throws a File Type error that DocumentReference does not
// likely needs a IG extension - implementationguide-resource-format
Instance: B-ink
InstanceOf: Binary
Title: "Binary example using Binary of png"
Description: "Example of a binary ink signature using Binary."
* contentType = #image/png
* data = "ig-loader-ink.png"

Instance: J-hello-world
InstanceOf: Binary
Title: "Binary example using Binary of json"
Description: "Example of a json hello world using Binary."
* contentType = #application/json
* data = "ig-loader-hello-world.json"

Instance: x-hello-world
InstanceOf: Binary
Title: "Binary example using Binary of xml"
Description: "Example of a xml hello world using Binary."
* contentType = #application/xml
* data = "ig-loader-hello-world.xml"

