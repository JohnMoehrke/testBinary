# testBundle

This creates IG with binary examples using the [IG Publisher ig-loader BinaryAdjunctFile feature](https://confluence.hl7.org/pages/viewpage.action?pageId=66938614#ImplementationGuideParameters-BinaryAdjunctFiles), to show that binary is not working with TEXT files.

<div markdown="1" class="dragon">

- [DocumentReference of a TEXT data](DocumentReference-Dr-hello-world.html) works
  - **Note that [DocumentReference can not have the contentType populated](DocumentReference-Dr-hello-world-not.html), although the documentation says it should be.**
  - [Profiled DocumentReference](DocumentReference-Dr-Ink-profiled.html) works
- [Binary of a PNG](Binary-B-ink.html) works
- [Binary of a TEXT](Binary-B-hello-world.html) works
- [Binary of a JSON](Binary-J-hello-world.html) works
- [Binary of a XML](Binary-x-hello-world.html) works
- [Binary of a PDF](Binary-p-hello-world.html) works
- [Document Bundle of a DocumentReference with a url of a web page](Bundle-hello-bundle.html)
  - **throws an info warning: because document bundles must have all References in the Bundle, and .url are treated as References here**
  
</div>
<br clear="all">

- [GitHub repo](https://github.com/JohnMoehrke/testBinary)
- [ig publisher still fails](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/ig-loader.20examples) -- CLOSED
  - [ig publisher issue](https://github.com/HL7/fhir-ig-publisher/issues/355) -- CLOSED
- [chat thread](https://chat.fhir.org/#narrow/stream/179252-IG-creation/topic/binary.20resources)
- [sushi chat thread](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/.22Big.20data.22)
- [sushi binary adjunct chat thread](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/Binary.20Adjunct)
  - with resolved [sushi bug](https://github.com/FHIR/sushi/issues/1005)
