# test Binary attachments

GitHub repo: https://github.com/JohnMoehrke/testBinary

CI build - http://build.fhir.org/ig/JohnMoehrke/testBinary/branches/main/index.html

This IG tests the IG Publisher ig-loader BinaryAdjunctFile feature. Results below were observed in generated resource JSON with IG Publisher 3.0.1.

Successful attachment loading means the `ig-loader-...` marker in `Attachment.id` is removed and the file is embedded in `Attachment.data`. An unchanged marker with no data means loading failed, even if an HTML example page was generated. Binary resources instead put their loader marker in `Binary.data`; success replaces that marker with the base64 file content.

| Pattern | Observed result |
| --- | --- |
| Binary of PNG, TEXT, JSON, XML, PDF, or FHIR R4 CQL (`text/cql`) | **PASS:** file data is embedded with the expected contentType. |
| Binary requesting markdown or FHIR-specific JSON/XML contentType | **PARTIAL:** file data loads, but contentType is inferred from the extension rather than preserving the requested value. |
| DocumentReference of TEXT or CQL, with or without contentType | **FAIL:** `content.attachment.id` retains `ig-loader-...`; no attachment data is embedded. |
| DocumentReference of markdown, or TEXT with other attachment metadata | **FAIL:** the loader ID remains; no attachment data is embedded. |
| Profiled DocumentReference of PNG | **FAIL:** the loader ID remains; no attachment data is embedded. |
| Multi-attachment DocumentReference (TEXT, PNG, JSON, XML, PDF, CQL) | **MIXED:** all six file-loaded attachments retain their loader IDs without data; all six Binary URL links point to populated Binary resources. |
| DocumentReference linking to a CQL Binary | **PASS as a link:** the target Binary contains CQL data. The attachment uses a URL, not ig-loader. |
| Profiled Media of PNG using ig-loader | **FAIL:** `content.id` retains `ig-loader-ink.png`; no content data is embedded. |
| FHIR Library of CQL | **PASS:** the loader ID is removed, CQL data is embedded, and translated ELM is generated. |
| Media or DocumentReference with an external URL | **LINK ONLY:** not an ig-loader test. The document Bundle example produces a warning about the external URL. |

See the [IG homepage source](input/pagecontent/index.md) for individual example links and details.

References:
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
