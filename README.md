# xvrl
Extensible Validation Report Language

Schema, documentation and other resources for a generalized and extensible validation report language. It should incorporate main concepts that can be expressed in SVRL (Schematron Validation Report Language) and the output of other XML validators such as Jing for Relax NG or Xerces for XML Schema (XSD).

## Data Formats to be Validated

XVRL documents should not be limited to hold XML validation reports. It may be extended to hold also JSON Schema validation reports.

Messages from epubcheck should also be representable in XVRL.

## Locators

For individual XML files, the canonical error locator will be a hierarchical XPath expression. The paths should support several syntaxes that are already supported by SVRL, plus maybe an EQname (`Q{namespace-uri}local-name`) syntax.

For JSON documents, multiple locator syntaxes may be supported (JsonPath, JSON Pointer, XPath map/array selectors, …).

Locators should also be extensible to files that reside in archives.

A special and optional locator attribute called `@provenance` or `@srcpath` may hold the location in the original file, in a multi-step conversion pipeline. (For example, `file:///C:/myfile.docx!word/document.xml?xpath=/w:document/w:body/w:p[12]` – the actual syntax and semantics of this attribute are not strictly specified)

## Syntaxes for Reports

A report document may be made available in an alternative JSON syntax.

XVRL messages can be given in plain text, XML (including XHTML), or JSON (which, if embedded in XML, appears as plain text but may be interpreted by an XPath-3.1-compliant report renderer if the text nodes are declared as containing JSON by some attribute).

## Localization

XVRL should be able to hold versions of a message in multiple natural languages. 

There may also be a simple templating mechanism that can replace placeholders in natural-language messages with more formalized information that is somehow stored alongside the message. This allows late localization, while conventionally, in SVRL, messages are stored fully localized. In XVRL, all three approaches should be supported: All messages in a single language

## Severity

In contrast to Schematron/SVRL, there should be a fixed severity vocabulary (fatal-error, error, warning, info), and the severity should be an attribute called 'severity', not 'role'.

## Other Attributes

Reports may contain any other attributes unless they are in the `xml` and `xvrl` namespaces. (Namespace URI for `xvrl` still to be determined.)
