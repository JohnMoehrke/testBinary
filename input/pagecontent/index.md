
This creates IG with binary examples using the [IG Publisher ig-loader BinaryAdjunctFile feature](https://build.fhir.org/ig/FHIR/ig-guidance/binaries.html).

<div markdown="1" class="dragon">

ig-loader does not fully work.
- contentType should be allowed and used
- other elements of attachment should be allowed (title, creation, etc)

</div>
<br clear="all">

### How to interpret the results

The results below were checked in the generated resource JSON with IG Publisher 3.0.1. Generating an HTML example page does **not** mean ig-loader successfully loaded its file.

- **PASS (attachment loading):** the `ig-loader-...` marker in `Attachment.id` is removed and the file is embedded as base64 in `Attachment.data`.
- **FAIL (attachment loading):** `Attachment.id` still contains `ig-loader-...` and no file data is embedded. This occurs in the DocumentReference and Media ig-loader examples below.
- **PASS (Binary loading):** the marker in `Binary.data` is replaced by base64 file data. The resource's own `Binary.id` is not a loader marker and is expected to remain.
- **PARTIAL (Binary contentType):** file data loads, but the requested contentType is replaced by the type inferred from the file extension.
- **LINK ONLY:** an attachment URL points to a Binary or external resource; the attachment itself does not use ig-loader. A Binary link works here when its target Binary has loaded data.

### Binary examples:

- [Binary of a PNG](Binary-B-ink.html) works
- [Binary of a TEXT](Binary-B-hello-world.html) works
- [Binary of a JSON](Binary-J-hello-world.html) works
- [Binary of a XML](Binary-x-hello-world.html) works
- [Binary of a PDF](Binary-p-hello-world.html) works
- [Binary of CQL](Binary-C-hello-world.html) works with `text/cql`
- **Binary does not fully work with specified contentType, as the contentType is ignored, and the file extension is used to determine the contentType instead.**
  - [Binary of a TEXT MARKDOWN with contentType specified](Binary-B-hello-world-markdown.html): **PARTIAL**, data loads but is marked as text/plain instead of text/markdown
  - [Binary of a XML with fhir contentType specified](Binary-x-hello-world-mime.html): **PARTIAL**, data loads but is marked as application/xml instead of application/fhir+xml
  - [Binary of a JSON with fhir contentType specified](Binary-J-hello-world-mime.html): **PARTIAL**, data loads but is marked as application/json instead of application/fhir+json

### DocumentReference examples:

- [DocumentReference of TEXT without contentType](DocumentReference-Dr-hello-world-no-contentType.html): **FAIL**, `content.attachment.id` retains `ig-loader-hello-world.txt`, with no data
- [DocumentReference of TEXT with contentType](DocumentReference-Dr-hello-world.html): **FAIL**, the same loader ID remains, with no data
- [DocumentReference of CQL without contentType](DocumentReference-Dr-hello-world-cql-no-contentType.html): **FAIL**, `content.attachment.id` retains `ig-loader-hello-world.cql`, with no data
- [DocumentReference of CQL with contentType](DocumentReference-Dr-hello-world-cql.html): **FAIL**, the same loader ID remains, with no data
- [DocumentReference linking to a CQL Binary](DocumentReference-Dr-hello-world-cql-binary.html): **PASS as a link**, uses an attachment URL with `text/cql`; the target Binary contains the file data
- **Populating contentType does not cause ig-loader to load these DocumentReference attachments. Omitting it also fails in this build.**
  - [Another DocumentReference of TEXT with contentType](DocumentReference-Dr-hello-world-mime.html): **FAIL**, the loader ID remains, with no data
  - [DocumentReference of a markdown txt file](DocumentReference-Dr-hello-world-markdown.html): **FAIL**, the loader ID remains, with no data
  - [DocumentReference with other attachment metadata](DocumentReference-Dr-hello-world-not.html): **FAIL**, the loader ID remains, with no data

- [DocumentReference with many content attachments both data and Binary](DocumentReference-all-contents.html): **MIXED**, all six file-loaded attachments (TEXT, PNG, JSON, XML, PDF, CQL) retain their `ig-loader-...` IDs without data. All six Binary URL links point to populated Binary resources; those links do not use attachment ig-loader processing.

The CQL examples use the same `hello-world.cql` source library with `using FHIR version '4.0.1'` and a simple greeting expression in Patient context. The [Hello World Library](Library-HelloWorld.html) **successfully loads** the CQL source: its attachment loader ID is removed, CQL data is embedded, and translated ELM XML is generated. The Binary and DocumentReference patterns demonstrate CQL source (`text/cql`), not translated ELM JSON or XML. The multi-attachment example includes CQL both as an ig-loader attachment and as a link to a Binary.

### Profiling DocumentReference

**The intended test is whether a profile can require contentType while using ig-loader. In this build, neither the profiled example with contentType nor the unprofiled examples omitting it successfully load their attachments. Relaxing the profile therefore does not demonstrate a working workaround.**
- [Profile of DocumentReference that should have contentType required](StructureDefinition-DocumentReferenceFoo.html) 
- [Profiled DocumentReference](DocumentReference-Dr-Ink-profiled.html): **FAIL**, `content.attachment.id` retains `ig-loader-ink.png`, with no data

### Media example

Note that Media is removed from FHIR in R5. So it only exists in R4. Thus recommendation is to use DocumentReference in R4.

- [Profile on Media](StructureDefinition-MediaFoo.html)
- [Media example](Media-Media-hello-world.html): **LINK ONLY**, uses an external URL, not ig-loader
- [Media using ig-loader](Media-Media-Ink-profiled.html): **FAIL**, `content.id` retains `ig-loader-ink.png`, with no data

### Bundle warning when it includes a DocumentReference with a url

<div markdown="1" class="dragon">

**Fail: Bundle of a Bundle with a DocumentReference**

- [Document Bundle of a DocumentReference with a url of a web page](Bundle-hello-bundle.html)
  - Fail: throws an info warning: because document bundles must have all References in the Bundle, and .url are treated as References here. As an info, it is challenging the author to check their work and ignorewarning if they really mean it.
  
</div>
<br clear="all">

### References:

- [Documentation on BinaryAdjunctFile](https://build.fhir.org/ig/FHIR/ig-guidance/binaries.html)
- [GitHub repo](https://github.com/JohnMoehrke/testBinary)
- [ig publisher still fails](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/ig-loader.20examples) -- CLOSED
  - [ig publisher issue](https://github.com/HL7/fhir-ig-publisher/issues/355) -- CLOSED
- [chat thread](https://chat.fhir.org/#narrow/stream/179252-IG-creation/topic/binary.20resources)
- [sushi chat thread](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/.22Big.20data.22)
- [sushi binary adjunct chat thread](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/Binary.20Adjunct)
  - with resolved [sushi bug](https://github.com/FHIR/sushi/issues/1005)
- [DocumentReference contentType can not be populated](https://github.com/HL7/fhir-ig-publisher/issues/1257) -- WRONGLY CLOSED, as it still happens.
- [ig-loader does not allow any attachment elements](https://github.com/HL7/fhir-ig-publisher/issues/1272)
