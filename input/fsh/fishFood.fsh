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
Title: "DocumentReference text file data"
Description: "Example of a hello world binary using DocumentReference. This does not have the contentType specified, and it will be filled by ig-loader based on the file extension."
* status = #current
* content.attachment.id = "ig-loader-hello-world.txt"
//* content.attachment.contentType = #text/plain

Instance: Dr-hello-world-not
InstanceOf: DocumentReference
Title: "Failed DocumentReference text file because of populated contentType"
Description: "Example of a hello world binary using DocumentReference that fails because contentType is populated. This will result in a DocumentReference that has not been loaded with the attachment, but rather holding in the id field exactly what is in this example."
* status = #current
* content.attachment.id = "ig-loader-hello-world.txt"
* content.attachment.contentType = #text/plain

Instance: Dr-Ink-profiled
InstanceOf: DocumentReferenceFoo
Title: "DocumentReferenceFoo example using Ink binary"
Description: "Example of a DocumentReference data of an ink signature png."
* status = #current
* content.attachment.id = "ig-loader-ink.png"
//* content.attachment.contentType = #image/png

Instance: all-contents
InstanceOf: DocumentReference
Title: "DocumentReference with many contents"
Description: "Example DocumentReference with many content of each kind of binary."
* status = #current
* content[+].attachment.id = "ig-loader-hello-world.txt"
//* content[=].attachment.contentType = #text/plain
* content[+].attachment.id = "ig-loader-ink.png"
//* content[=].attachment.contentType = #image/png
* content[+].attachment.id = "ig-loader-hello-world.json"
//* content[=].attachment.contentType = #application/json
* content[+].attachment.id = "ig-loader-hello-world.xml"
//* content[=].attachment.contentType = #application/xml
* content[+].attachment.id = "ig-loader-hello-world.pdf"
//* content[=].attachment.contentType = #application/pdf
* content[+].attachment.url = "Binary/B-hello-world"
* content[=].attachment.contentType = #text/plain
* content[+].attachment.url = "Binary/B-ink"
* content[=].attachment.contentType = #image/png
* content[+].attachment.url = "Binary/J-hello-world"
* content[=].attachment.contentType = #application/json
* content[+].attachment.url = "Binary/x-hello-world"
* content[=].attachment.contentType = #application/xml
* content[+].attachment.url = "Binary/p-hello-world"
* content[=].attachment.contentType = #application/pdf


Instance: B-hello-world
InstanceOf: Binary
Title: "Binary example using Binary of text"
Description: "Example of a binary hello world using Binary."
* contentType = #text/plain
* data = "ig-loader-hello-world.txt"


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

Instance: p-hello-world
InstanceOf: Binary
Title: "Binary example using Binary of pdf"
Description: "Example of a pdf hello world using Binary."
* contentType = #application/pdf
* data = "ig-loader-hello-world.pdf"

// The advance directive example uses a web url for the attachment, and is included in a FHIR Document Bundle; therefore the document bundle requirements to include all References in the bundle throws an Info warning indicating that the attachment url is not included in the Bundle. This warning is proper, but not easy to understand.


Alias: $loinc = http://loinc.org

Instance: ad-patient-123
InstanceOf: Patient
Title: "Example patient for advance directive"
Description: "Example patient resource for the advance directive example."
Usage: #inline
* active = true
* name[0].family = "Doe"
* name[0].given[0] = "John"

Instance: advance-directive-123
InstanceOf: DocumentReference
Title: "Example using DocumentReference with a web url"
Description: "Example of a DocumentReference using a link to a web site."
Usage: #inline
* status = #current
* type.coding[0] = $loinc#75310-3 "Health concerns Document"
* type.coding[+] = $loinc#55188-7 "Patient data Document"
* date = "2025-08-01T10:00:00Z"
* subject = Reference(ad-patient-123)
* content.attachment.contentType = #application/pdf
* content.attachment.url = "https://server.example.com/blah.pdf"
* content.attachment.title = "Advance Directive Document"

Instance: ad-composition-123
InstanceOf: Composition
Title: "Example using Composition with a web url"
Description: "Example of a Composition using a link to a web site."
Usage: #inline
* status = #final
* type.coding[0] = $loinc#11506-3
* date = "2025-08-01T10:00:00Z"
* title = "Advance Directive Document"
* author.display = "Dr. John Smith"
* subject = Reference(ad-patient-123)
* section[+].title = "Advance Directive"
* section[=].text.status = #generated
* section[=].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">This is the advance directive document for the patient.</div>"
* section[=].entry[0] = Reference(advance-directive-123)


Instance: hello-bundle
InstanceOf: Bundle
Title: "A bundle with various Binary and DocumentReference examples"
Description: "A bundle containing various Binary and DocumentReference examples."
* type = #document
* identifier.system = "urn:oid:2.999.724.4.8.10.200.10"
* identifier.value = "ac7a747c-a2c9-493c-ba39-4ac6997eed1e"
* timestamp = "2024-09-21T18:53:00.8116604+00:00"
* entry[+].resource = ad-composition-123
* entry[=].fullUrl = "https://fhir.example.com/Composition/ad-composition-123"
* entry[+].resource = advance-directive-123
* entry[=].fullUrl = "https://fhir.example.com/DocumentReference/advance-directive-123"
* entry[+].resource = ad-patient-123
* entry[=].fullUrl = "https://fhir.example.com/Patient/ad-patient-123"

