# test Binary attachments

GitHub repo: https://github.com/JohnMoehrke/testBinary

CI build - http://build.fhir.org/ig/JohnMoehrke/testBinary/branches/main/index.html

This creates IG with three examples, to show that binary is not working with TEXT files.

- DocumentReference of a TEXT binary works
- Binary of a PNG binary works
- Binary of a TEXT
  - throws an error: "unknown file type hello-world.txt"
  - but produces the right artifact
- Binary of a JSON
  - throws an error: "unknown file type hello-world.json"
  - but produces the right artifact
- Binary of a XML
  - throws an error: "unknown file type hello-world.xml"
  - but produces the right artifact
- Document Bundle of a DocumentReference with a url of a web page
  - throws an info warning: because document bundles must have all References in the Bundle, and .url are treated as References here
  

References:
- [ig-guidance on binary adjunct files](https://build.fhir.org/ig/FHIR/ig-guidance/binaries.html)
- [ig publisher still fails](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/ig-loader.20examples)
  - [ig publisher issue](https://github.com/HL7/fhir-ig-publisher/issues/355)
- [chat thread](https://chat.fhir.org/#narrow/stream/179252-IG-creation/topic/binary.20resources)
- [sushi chat thread](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/.22Big.20data.22)
- [sushi binary adjunct chat thread](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/Binary.20Adjunct)
  - with resolved [sushi bug](https://github.com/FHIR/sushi/issues/1005)

