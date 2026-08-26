# Epic Markup

**Epic poetry - Including Homer's *Iliad* - with LMNL markup:** OVERLAPPING HIERARCHIES enabled by XML, TEI, XSLT, iXML and XProc

Epic poetry is defined here broadly, to overlap related forms such as tragedy, melodrama, romance and satire. The focus here is on examples of epic as literary works that benefit from this approach to text encoding.

Two distinctions of epic as a literary genre are its universal scope (even when paradoxically narrow) and its use of a narrative voice or persona. Any such definitional categories can be the subject of research and testing (indeed, using text encoding technologies), and the point here is not to define or distinguish epic so much as explore it.

The developer is eager to hear of other epics, and of other works more broadly, to which LMNL may be usefully applied. The world is vast. 

<details><summary>What is LMNL</summary>
LMNL is the Layered Markup and Annotation Language, which defines a markup syntax and a data model designed to support data processing over text (expressed in Unicode).

Think of it as similar to XML, except:

- Different syntax for tags (*sawteeth*)
- Permits spans of tagged text to overlap one another (tagging 'does not always nest')

```
[book [n}1{]}
[para}[l [n}1.1{]}[phr}μῆνιν ἄειδε θεὰ Πηληϊάδεω Ἀχιλῆος{l]
[l [n}1.2{]}οὐλομένην,{phr] [phr}ἣ μυρίʼ Ἀχαιοῖς ἄλγεʼ ἔθηκε,{phr]{l]
[l [n}1.3{]}[phr}πολλὰς δʼ ἰφθίμους ψυχὰς Ἄϊδι προΐαψεν{l]
[l [n}1.4{]}ἡρώων,{phr] [phr}αὐτοὺς δὲ ἑλώρια τεῦχε κύνεσσιν{l]
[l [n}1.5{]}οἰωνοῖσί τε πᾶσι,{phr] [phr}Διὸς δʼ ἐτελείετο βουλή,{phr]{l]
[l [n}1.6{]}[phr}ἐξ οὗ δὴ τὰ πρῶτα διαστήτην ἐρίσαντε{l]
[l [n}1.7{]}Ἀτρεΐδης τε ἄναξ ἀνδρῶν καὶ δῖος Ἀχιλλεύς.{phr]{l]{para]
...{book]
```

More information about LMNL, with more examples, can be found in the [Laminator repository](https://github.com/wendellpiez/Laminator)

</details>

## Dependencies and prerequisites

Internal plumbing relies heavily (entirely) on XProc, XSLT and XPath. This is your chance to see them in action.

This means no Javascript outside of a little client code isolated in HTML files. No framework, no live back end.

Running XProc requires an XProc engine supporting an iXML parser. Both XML Calabash and Morgana XProcIIIse have been used successfully with the pipelines in this repository.

You should feel comfortable running a capable XProc engine (from the command line or coding platform). If you are not, keep in mind that most people who can do this started by watching someone else, so ask for help.

Similarly, you need `git` skills good enough to acquire a copy of the repository with its git submodule.

XSLT sounds scary but if you know what you are doing it is an incredible power tool. The size of the codebase alone speaks to its efficency as well as its power.

## Iliad

This repository holds several variant renditions of Homer's *Iliad*. As a rule they all share a common source, the PerseusDL encoding of the Monro and Allen OUP edition.

[LMNL encoded versions of the data](data/Iliad/lmnl/) intend to show a little of what can be done with a markup tagging syntax that *permits overlap*, and markup languages enabled by such a syntax, for research into epic poetry, and by implication, into much else.

*Winged words*: Some preliminary research results can be seen in the [data/Iliad/rangemaps](data/Iliad/rangemaps) folder.

Planned: some project results will be published on the developer's [Raven Tracks portal](https://raventracks.org) alongside other resources and projects.

## Other works

See the [data folder](./data/) for other works in progress as well, documented in place. The intent is to create these as relatively self-contained units even while the Homer work continues.

### Milton, *Paradise Lost*

*Paradise Lost* with its verse enjambments has always been a favorite example for illustrating overlapping phenomena.

Book I is provided here with conversion pipelines producing LMNL from an EPUB source (Public Domain Wikidata file). The EPUB encoding is discarded and the conversion works from plain text.

This demonstrates the production of LMNL data with multiple concurrent hierarchies (MCH) expressed as overlapping ranges, while not speaking to the question of **modeling** this text.

Nonetheless even without formalizing a model, we can see useful results.

## Cloning the repository

To run the processes for yourself: all the pipelines in the repository have successfully been run in a conformant XProc 3.0/3.1 engine. Some pipelines require MarkupBlitz (bundled with XML Calabash). For ease of use, "build" pipelines are deployed (recognizable by names in `ALL-CAPITALS.xpl`), which can be executed standalone, i.e. without configuring any bindings or dependencies.

This project uses the Laminator for LMNL processing (see below), installed in the [`lib` folder](./lib/).

It is set up as a git submodule, so it requires initialization and update for the repository runtimes to work: see git documentation on initializing (`git submodule init`) and updating (`git submodule update --remote`).

## Namespaces

Internally, pipelines may sometimes handle XML without namespaces. Caution is warranted lest your assumptions betray you.

When needed, a common namespace may be assigned for elements not expected to be useful outside this repository:

```
xmlns:EPIC="https://github.com/wendellpiez/EpicMarkup/ns"
```

Caveat Proscriptor!

## Hall of Fame

[Another page](halloffame.md) represents a best effort at collecting some links for the student of epic poetry and especially Homer.

## XProc 3.0

XProc 3.0 is a language defined by a standardized open specification, used to describe simple and complex operations - to "define jobs" - to be performed over XML or other data (including HTML, JSON, plain text and other formats). These operations include both transformations (using XSLT and other means) and interactions with the system, such as reading, writing, segmenting and merging resources.

Think of XProc as a document- and data-oriented 'build' language. You can learn more about it on the Internet, or see another project by the developer, the [XProc Zone](https://xproc.zone).

## Laminator

The Laminator is a library written by the developer to handle a useful subset of LMNL, **Minimally Annotated Markup in LMNL** (MNML LMNL). MNML sacrifices some of the useful features of LMNL in favor of an implementation of core functionality that is much easier to design and test for its simplicity.

[The Laminator](https://github.com/wendellpiez/Laminator/)  is included with the project as repository submodule. While the Laminator supports only a subset of LMNL, it is entirely generic and agnostic with respect to vocabularies used for tagging; this permits this project to stick close to [TEI](https://tei-c.org) as a *lingua franca*.

When thinking about the Laminator, set aside thoughts of protective sheets of plastic in favor of fine and malleable precious metals such as gold and platinum.

## Editing LMNL

If you have gotten this far, possibly you will be intrigued to know you can work with LMNL natively in a text editor with some dedicated tooling and syntax coloring. See the [Laminator `lib` directory](lib/Laminator/lib/Textpad/) for more details.

## Acknowledgements

This work builds on foundations laid by others:

- Perseus project and contributors - for PerseusDL source data
- Other OSS projects and resources, for example WikiData and Wikimedia Commons
- XProc developers and community
- TEI developers and community
- iXML developers and community

It is dedicated to everyone who believed in LMNL and everyone who has thoughtfully challenged it, with grateful thanks, as well as to the memory of that titan of Markup, C. Michael Sperberg-McQueen.


---
20260607
