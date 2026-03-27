# testBundle

This creates IG with binary examples using the [IG Publisher ig-loader BinaryAdjunctFile feature](https://build.fhir.org/ig/FHIR/ig-guidance/binaries.html).

<div markdown="1" class="dragon">

ig-loader does not fully work.
- contentType should be allowed and used
- other elements of attachment should be allowed (title, creation, etc)

</div>
<br clear="all">

### Binary examples:

- [Binary of a PNG](Binary-B-ink.html) works
- [Binary of a TEXT](Binary-B-hello-world.html) works
- [Binary of a JSON](Binary-J-hello-world.html) works
- [Binary of a XML](Binary-x-hello-world.html) works
- [Binary of a PDF](Binary-p-hello-world.html) works
- **Binary does not fully work with specified contentType, as the contentType is ignored, and the file extension is used to determine the contentType instead.**
  - [Binary of a TEXT MARKDOWN with contentType specified](Binary-B-hello-world-markdown.html) fails, is marked as text/plain instead of text/markdown
  - [Binary of a XML with fhir contentType specified](Binary-x-hello-world-mime.html) fails as it is marked as application/xml instead of application/fhir+xml
  - [Binary of a JSON with fhir contentType specified](Binary-J-hello-world-mime.html) fails as it is marked as application/json instead of application/fhir+json

### DocumentReference examples:

- [DocumentReference of a TEXT data without contentType](DocumentReference-Dr-hello-world.html) works
- **DocumentReference can't have contentType populated**
  - [DocumentReference of a TEXT data with contentType](DocumentReference-Dr-hello-world-mime.html) fails as ig-loader does not work
  - [DocumentReference of a markdown txt file](DocumentReference-Dr-hello-world-markdown.html) fails as ig-loader does not work

- [DocumentReference with many content attachments both data and Binary](DocumentReference-all-contents.html) works as well as the other examples.

### Profiling DocumentReference

**Because contentType can't be populated a Profile on DocumentReference can't require the contentType to be populated if any examples are going to use ig-loader. Thus one either has proper Profiles and can't take advantage of ig-loader, or one can use ig-loader but has to have less strict Profiles.**
- [Profile of DocumentReference that should have contentType required](StructureDefinition-DocumentReferenceFoo.html) 
- [Profiled DocumentReference](DocumentReference-Dr-Ink-profiled.html) works

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
