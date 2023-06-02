# test Binary attachments

This creates IG with three examples, to show that binary is not working with TEXT files.

- DocumentReference of a TEXT binary works
- Binary of a PNG binary works
- Binary of a TEXT throws an error:

> Binary (l1/c2)	error	Unknown file type helloWorld.txt

- [ig publisher still fails](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/ig-loader.20examples)
  - [ig publisher issue](https://github.com/HL7/fhir-ig-publisher/issues/355)
- [chat thread](https://chat.fhir.org/#narrow/stream/179252-IG-creation/topic/binary.20resources)
- [sushi chat thread](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/.22Big.20data.22)
- [sushi binary adjunct chat thread](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/Binary.20Adjunct)
  - with resolved [sushi bug](https://github.com/FHIR/sushi/issues/1005)

## Modality warning

Note: that the new modality element in FHIR R5 DocumentReference will throw a warning if you do not have dependency on the dicom vocabulary. This happens also in ImagingStudy in previous versions.

> warning	ValueSet http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_33.html not found by validator

Either add the warning(s) to ignoreWarnings.txt, or add the dependency to the dicom IG to sushi-config.yaml. This IG did both.

```
dependencies:
  fhir.dicom:
    uri: http://fhir.org/packages/fhir.dicom
    version: 2023.1.20230123
```

