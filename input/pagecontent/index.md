# testBundle

<div markdown="1" class="dragon">

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

</div>
<br clear="all">

- [GitHub repo](https://github.com/JohnMoehrke/testBinary)
- [ig publisher still fails](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/ig-loader.20examples)
  - [ig publisher issue](https://github.com/HL7/fhir-ig-publisher/issues/355)
- [chat thread](https://chat.fhir.org/#narrow/stream/179252-IG-creation/topic/binary.20resources)
- [sushi chat thread](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/.22Big.20data.22)
- [sushi binary adjunct chat thread](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/Binary.20Adjunct)
  - with resolved [sushi bug](https://github.com/FHIR/sushi/issues/1005)
