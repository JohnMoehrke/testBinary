
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

- [Binary of a PNG](Binary-B-ink.html): **PASS**, embeds the ink signature with `image/png`
- [Binary of TEXT](Binary-B-hello-world.html): **PASS**, embeds the hello world text with `text/plain`
- [Binary of JSON](Binary-J-hello-world.html): **PASS**, embeds the JSON file with `application/json`
- [Binary of XML](Binary-x-hello-world.html): **PASS**, embeds the XML file with `application/xml`
- [Binary of PDF](Binary-p-hello-world.html): **PASS**, embeds the PDF file with `application/pdf`
- [Binary of CQL](Binary-C-hello-world.html): **PASS**, embeds the FHIR R4 CQL source with `text/cql`
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
  - [DocumentReference with other attachment metadata](DocumentReference-Dr-hello-world-not.html): **FAIL**, the loader ID remains, with no data. The supplied title `Hello World Text File` is preserved; title preservation does not indicate successful loading, and this example does not isolate title from the other metadata.

- [DocumentReference with many content attachments both data and Binary](DocumentReference-all-contents.html): **MIXED**, all six file-loaded attachments (TEXT, PNG, JSON, XML, PDF, CQL) retain their `ig-loader-...` IDs without data. All six Binary URL links point to populated Binary resources; those links do not use attachment ig-loader processing.

The CQL examples use the same `hello-world.cql` source library with `using FHIR version '4.0.1'` and a simple greeting expression in Patient context. The [Hello World Library](Library-HelloWorld.html) **successfully loads** the CQL source: its attachment loader ID is removed, CQL data is embedded, and translated ELM XML is generated. The Binary and DocumentReference patterns demonstrate CQL source (`text/cql`), not translated ELM JSON or XML. The multi-attachment example includes CQL both as an ig-loader attachment and as a link to a Binary.

### Profiling DocumentReference

**The intended test is whether a profile can require contentType while using ig-loader. In this build, neither the profiled example with contentType nor the unprofiled examples omitting it successfully load their attachments. Relaxing the profile therefore does not demonstrate a working workaround.**
- [DocumentReferenceFoo profile](StructureDefinition-DocumentReferenceFoo.html): fixes status to `current`; the proposed requirement for attachment contentType is commented out, so contentType is not currently required by this profile
- [Profiled DocumentReference](DocumentReference-Dr-Ink-profiled.html): **FAIL**, `content.attachment.id` retains `ig-loader-ink.png`, with no data

### Media example

Note that Media is removed from FHIR in R5. So it only exists in R4. Thus recommendation is to use DocumentReference in R4.

- [MediaFoo profile](StructureDefinition-MediaFoo.html): fixes status to `completed`; does not require contentType
- [Media example](Media-Media-hello-world.html): **LINK ONLY**, uses an external URL, not ig-loader. The title `Hello World PDF Link` is preserved; the specified `text/plain` does not match the URL's `.pdf` extension.
- [Media using ig-loader](Media-Media-Ink-profiled.html): **FAIL**, `content.id` retains `ig-loader-ink.png`, with no data

### Document Bundle and its inline resources

These inline instances are embedded as Bundle entries, not published as standalone example pages. Their links below open the Bundle JSON, where each resource can be inspected by its ID.

- [Document Bundle](Bundle-hello-bundle.html): contains a Composition, DocumentReference, and Patient. **LINK ONLY**, the attachment uses an external URL, not ig-loader. The Publisher reports an informational warning about that URL not being included in the document Bundle; this is separate from attachment loading failure.
- [ad-composition-123 (Composition entry)](Bundle-hello-bundle.json): the first entry describes the advance directive, references the patient, and includes a section pointing to the DocumentReference. The Composition title is `Advance Directive Document` and the section title is `Advance Directive`.
- [advance-directive-123 (DocumentReference entry)](Bundle-hello-bundle.json): links to the external PDF; the supplied attachment title `Advance Directive Document` is preserved.
- [ad-patient-123 (Patient entry)](Bundle-hello-bundle.json): John Doe, the subject shared by the Composition and DocumentReference.

### Explicit data, contained resources, and Provenance

These examples test explicit base64 data and resource references, not ig-loader. The presence of embedded data here therefore does not demonstrate successful file loading. Inline instances have no standalone page; their links open the containing resource's JSON. Broken generated narrative links are noted separately from the resource reference and attachment data results.

- [ExampleData (standalone DocumentReference)](DocumentReference-ExampleData.html): contains explicitly supplied base64 data for `Hello world!` with contentType `text/markdown`; no loader marker is used.
- [InlineData (contained DocumentReference)](Provenance-ProvenanceWithInlineData.json): contains the same explicitly supplied markdown data. It is embedded in both ProvenanceWithInlineData and ObservationWithInlineData, rather than published independently.
- [LinkToData (contained DocumentReference)](Provenance-ProvenanceWithInlineDataLink.json): **LINK ONLY**, points to an external markdown URL with `text/markdown`; no file data is embedded.
- [ProvenanceWithInlineData](Provenance-ProvenanceWithInlineData.html): contains InlineData and targets it using `#InlineData`; its author points to Practitioner/123. The resource contains the attachment data, but QA reports a broken generated narrative hyperlink to the contained DocumentReference.
- [ProvenanceWithExampleData](Provenance-ProvenanceWithExampleData.html): targets the standalone DocumentReference/ExampleData and records Practitioner/123 as author; the DocumentReference is referenced, not contained.
- [ProvenanceWithInlineDataLink](Provenance-ProvenanceWithInlineDataLink.html): contains LinkToData and targets it using `#LinkToData`; its author points to Practitioner/123. QA reports a broken generated narrative hyperlink to the contained DocumentReference; the external attachment URL is preserved.
- [ObservationWithInlineData](Observation-ObservationWithInlineData.html): a final hemoglobin observation of 13.5 g/dL for Patient/456; contains InlineData and references it through `derivedFrom`. QA recommends adding a performer and an effective time; those recommendations are unrelated to attachment loading.
- [ProvenanceWithInlinePractitioner](Provenance-ProvenanceWithInlinePractitioner.html): targets Observation/ObservationWithInlineData and contains its author Practitioner, referenced as `#123`. QA reports a broken generated narrative hyperlink to the contained Practitioner.

### Supporting patient and practitioner

- [Patient456 (published as Patient/456)](Patient-456.html): Jane Smith, the subject of ObservationWithInlineData; no attachment or ig-loader test.
- [Practitioner-123 (published as Practitioner/123)](Practitioner-123.html): John Doe, the author referenced by the Provenance examples; no attachment or ig-loader test. The same instance is also [contained in ProvenanceWithInlinePractitioner](Provenance-ProvenanceWithInlinePractitioner.json), where its local reference is `#123`.

### References:

- [Documentation on BinaryAdjunctFile](https://build.fhir.org/ig/FHIR/ig-guidance/binaries.html)
- [GitHub repo](https://github.com/JohnMoehrke/testBinary)
- [ig publisher is not handling DocumentReference right](https://chat.fhir.org/#narrow/channel/179252-IG-creation/topic/DocumentReference.20ig-loader.20is.20broken/with/634072838)
  - https://github.com/HL7/fhir-ig-publisher/pull/1420
- [ig publisher still fails](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/ig-loader.20examples) -- CLOSED
  - [ig publisher issue](https://github.com/HL7/fhir-ig-publisher/issues/355) -- CLOSED
- [chat thread](https://chat.fhir.org/#narrow/stream/179252-IG-creation/topic/binary.20resources)
- [sushi chat thread](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/.22Big.20data.22)
- [sushi binary adjunct chat thread](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/Binary.20Adjunct)
  - with resolved [sushi bug](https://github.com/FHIR/sushi/issues/1005)
- [DocumentReference contentType can not be populated](https://github.com/HL7/fhir-ig-publisher/issues/1257) -- WRONGLY CLOSED, as it still happens.
- [ig-loader does not allow any attachment elements](https://github.com/HL7/fhir-ig-publisher/issues/1272)
