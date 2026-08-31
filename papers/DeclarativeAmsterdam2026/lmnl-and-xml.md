
# LMNL and XML

Understanding LMNL through an XML lens is both understandable, and normal. The two are very different and distinct, but some similarities between them may help make LMNL at least somewhat familiar to XML practictioners.

DH practitioners know XML, and this initiative is aimed at DH, so for that reason as well, XML makes a good starting point for comparison. (Many other reasons as well, we can set aside.)

**Similarities** Both provide for declarative tagging; define your own tagging (extensibility); adaptive schemas; late binding to schemas.

Both syntaxes use the convention of start tags, end tags and "empties" (single tags in place, no start or end) to demarcate text ("tag" it), and both require start and end tags to pair up.

LMNL follows XML in some of its lower-level rules such as rules around naming, for convenience in integrating with XML systems.

**Difference** XML follows an *end-tag matching rule*, while LMNL syntax does not. This is so that LMNL tags can mark ranges, while XML tags need only mark the boundaries of an element tree.

**Difference** XML and LMNL syntax use different notations, so the tags look different. `<tagXML>...</tagXML>` versus  `[tagLMNL}...{tagLMNL]`

**Difference** Where XML has attributes, LMNL has annotations. In MNML LMNL (the LMNL subset supported by Laminator), as in XML, these appear in the data model as name/value pairs (i.e., named properties), and values are always strings or datatypes expressible as strings.

In LMNL (but not implemented by Laminator), annotations can be entire LMNL documents, with structure and markup, and can have their own annotations.

The subset of LMNL implemented by the Laminator is MNML, for *Minimally Annotated Markup in LMNL*. Its specifications, with luck, can be found in the Laminator repository (a submodule of this repository).

**Difference** XML is specified as a syntax with an implicit data model, while LMNL is defined as a data model, with a syntax (called "LMNL syntax" or "sawteeth") proposed to go with it. This difference makes little difference to users of LMNL tagging, but a big difference for developers.

The fact that syntax and model are conceptually distinct is something LMNL has in common with XML. It means, among other things, that alternative platforms and implementations are thinkable and viable for LMNL -- and thus for its MNML subset.
## Exploratory Markup

It is easier to design models for documents using XML than using SGML, since SGML's requirement for a schema (DTD) prior to parsing a document effectively embedded the DTD into the modeling process, creating a chicken/egg problem. No document could exist before a schema was provided for it, in the form of a DTD.

XML improved on this situation by defining syntactic well-formedness: i.e., a document could be parsed definitively and deterministically without reference to a schema, assuming all entities could be expanded. So documents could be created -- and models designed -- with schemas created only as a codification of what was known about a document set, not a definition of a document type. This is a subtle but important distinction.

LMNL goes a step even further. Because elements in XML must nest, a new element type cannot be introduced without considering its relation to the defined types already in place, with respect to containment. In LMNL this is no longer the case. Thus new range types can be introduced at any time for any reason, even when they conflict or compete, on either syntactic or semantic levels. Normalization can occur later.

This makes LMNL an advantage when we need to make it up as we go.

See the [Presentation Writeup](presentation-writeup.md) for more on this interesting topic.

## End-tag matching rule

What stood in the way of our doing this? 25 years ago, even while the XML technology stack made available unprecedented capabilities -- effectively for free, to those who knew how to find it -- we lacked high quality data to help jumpstart markup. Since transcription and interpretive markup are really two separate activities, being able to adopt a good transcription makes two jobs into one. But there was one other big impediment to free-form markup for exploration, namely XML's end-tag matching rule.

In effect, the ETMR means that a single tree of elements can be unambiguously distinguished, so with each element we can identify not only neighbor elements but contained and containing elements. Any elements are either entirely discrete (with no contents in common), or clearly composed one inside the other:

- An element whose end tag appears before my start tag, precedes me
- An element whose start tag appears after my end tag, follows me
- Otherwise, an element that starts after my start, must end before my end (following the ETMR), and appears inside me
- And an element whose start tag precedes mine, must enclose or contain me, and its end tag must appear after mine (following the EMTR)

It is possible to eliminate the end-tag matching rule and retain a rule that each end tag must pair unambiguously with a start tag given prior to it. If we stipulate that this can be the most recent start tag with the same name, everything can be matched up; if we add to this a convention on representing a range ID on the tag, we can even provide for ranges of the same name to overlap one another ("sibling rivalry".)

When the EMTR is not followed, as long as tags still appear in pairs, we have these categories plus two more:

- A range that starts before my start and ends before my end, but after my start, overlaps me at the start
- A range that starts after my start and before my end, and ends after my end, overlaps me at the end

(more examples can be given in docs XXX)

## Tags, tag order and text

Tag ordering in LMNL may appear sometimes to be "slippery", inasmuch that when they appear at the same offset (i.e., with no intervening space or characters), the order of tags may not be preserved in processing.

(XXX example)

The easiest solution to this is simply to use whitespace or other data between tags, which has the effect of fixing their relative order.

Alternatively, define a normative set of ordering rules and enforce them with tag-rewriting operations.

-----
