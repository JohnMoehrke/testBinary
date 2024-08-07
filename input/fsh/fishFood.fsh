// see https://confluence.hl7.org/pages/viewpage.action?pageId=66938614#ImplementationGuideParameters-BinaryAdjunctFiles

Profile:        DocumentReferenceFoo
Parent:         DocumentReference
Title:          "Just a simple profile of DocumentReference"
Description:    "not much to say"
* status = #current
// since DocumentReference ig-loader can't have .contentType specified, then the profile can't require contentType
//* content.attachment.contentType 1..1


Instance: Dr-hello-world
InstanceOf: DocumentReference
Title: "Binary example using DocumentReference"
Description: "Example of a hello world binary using DocumentReference. This will load the binary, but will NOT populate the contentType."
* status = #current
* content.attachment.id = "ig-loader-hello-world.txt"
// note you can not populate the contentType

Instance: Dr-hello-world-not
InstanceOf: DocumentReference
Title: "Failed Binary example using DocumentReference"
Description: "Example of a hello world binary using DocumentReference that fails because contentType is populated. This will result in a DocumentReference that has not been loaded with the attachment, but rather holding in the id field exactly what is in this example."
* status = #current
* content.attachment.id = "ig-loader-hello-world.txt"
* content.attachment.contentType = #text/plain

Instance: Dr-Ink-profiled
InstanceOf: DocumentReferenceFoo
Title: "Binary example using DocumentReferenceFoo profile"
Description: "Example of a ink binary using a profiled DocumentReference."
* status = #current
* content.attachment.id = "ig-loader-ink.png"


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

