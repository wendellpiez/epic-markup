
# What can we see when we can see overlap?

**Modeling Homer's Iliad with exploratory markup: A MNML LMNL case study**

Declarative Amsterdam 2026

## The opportunity

With new tools come new capabilities, leading to new ideas -- and to new possibilities for old ideas.

One such old idea is LMNL, the Layered Markup and Annotation Language. In this paper I explore using LMNL to provide descriptive markup to the *Iliad* of Homer (the Greek text in a modern edition).

[Some background on LMNL](./lmnl-background.md) is described on another page.

## What are we trying to achieve?

What can we learn about markup by working a system that does not restrict us to a single hierarchy, once for all?

What can we learn about Homer's poem, about epic and about poetry, from seeking to apply markup to phenomena at both large and small levels of scale, from word or syllable level on up to speeches, scenes and books?

## What is LMNL about and why is it suitable?

See the companion page on [LMNL and XML](lmnl-and-xml.md) for more on how LMNL is similar, and different, from XML.

Details aside, the main differentiator between LMNL tagging and XML tagging is that *LMNL tagging tolerates overlap*.

The nomenclature changes with the mental model: we no longer mark "elements" with tags; instead we mark *ranges*.

LMNL's tolerance of overlap also makes it suitable as the first step in marking texts that show not single hierarchies, but **Multiple Concurrent Hierarchies** (MCH).

And because it is permissive, it can also be used without schemas or rule sets, until such time in the lifecycle of a dataset to normalize and standardize the tagging, for regularity and predictability in processing. If publication is not the aim, for a LMNL document, this can be late or never.

<details>
<summary>Exploratory Markup</summary>

**Exploratory Markup** is the idea is that markup might itself become an interpretive instrument, a research device, for both learning about a text, and tracing and exposing findings relating to it.

This is the opposite of the schema-driven paint-by-numbers game we most often play today with markup. Having acquired a text, we determine (or someone tells us) which schema and tag set to use. Then the art becomes fitting the text into tags defined for the available (approved) features, without resorting to "creative" applications of tags and tagging patterns.

Essentially, we "win" when our text (and our requirements) are conventional enough - or can be made to be - to find expression using the off-the-shelf tagging system. (We have achieved valid results!) To a great degree, outcomes are determined at the start by the choice of tag set or schema and its suitability for the application(s) intended.

Exploratory markup is based on the idea that for the scholar and student, tagging a text should be just the opposite. How can we know what tags we can use before we have even seen the text?

When working with a text, we should be able to make up tags describing and outlining phenomena as they appear, with no prior commitment to any scheme, any schema, or even any project result (web site or publication). Producing a publication might be a helpful beneficial outcome of a markup project, but it should not have to be its only motive or driver. When understanding a text's own unique organization, composition and internal structure counts for something in itself, exploratory markup opens a way forward. Tag the features; then assess and interpolate a schema.
</details>

### LMNL in application

As noted, LMNL has two features that make it more suitable for exploratory markup than XML:

- Tolerating overlap means that we can add new ranges freely any time at no cost
- Because hierarchies are not imposed, "natural outlines" become visible

Both of these reasons must be considered in the context of an actual scholarly *workflow* (to use a term of art appropriated from UI/UX). Each one is far-reaching in its own way.

Either XML or LMNL assumes that the practitioner has enough understanding to be able to make good judgements about content, while learning about markup. It may be that XML makes good "training wheels" for LMNL. But the opposite might also be the case.

### Here Be XSLT

Additionally, the present project assumes the user also has the technical expertise to design and build project results -- artifacts, publishable versions, analysis.

This project does not (and may never) amount to a "publishing system" in the sense that given inputs (valid to a given schema and tagging use profile or rule set) might always "drop in" to produce good outputs, even without any extension. On the contrary, extension -- or rather, adaptation, since we are not canning a process for a nominally stable input format we will actually never see again -- is not the exception, but the rule -- constant, endless extension and adaptation, like a highway system that is never completed. (Think of it not as a job or a chore, but a life!) A narrow focus on a small set of texts in a particular genre also helps.

That being said, there is no reason in principle that any set of validation and production pipelines, contrived to make some kind of useful outputs for some set of inputs, should not also be useful to as many encoding specialists as want to use it. (Rules for a LMNL Shakespeare remain to be promulgated. And so much else.) As always, specification and communication are the key.

## Laminator: project and architecture

This project uses the **Laminator** library to support its MNML LMNL syntax processing; it is included in the EpicMarkup repository as a git submodule.

See the [Laminator repository](https://github.com/wendellpiez/Laminator/tree/main) for much more. **Laminator** (or "the Laminator") runs in an XProc 3.0 processor such as XML Calabash or Morgana IIIse (both Java applications).

The Laminator is designed to be used by calling libraries, that is to say XProc pipelines that embed (import) Laminator pipelines, to use their functionality internally. This project offers a number of examples of these.

An attempt is being made to provide XProc pipeline definitions and XSLT transformation code with comments, and to keep them up to date.

## Epic Results (so far)

See the general [Iliad Reading Notes](../Iliad_reading-notes.md) for a summary version of reading notes.

In Amsterdam, it will be up to the audience how deeply we go into Ancient Greek and the epic tradition; poetic language and oral tradition; rhapsody as a cultural and literary form; narrative and genre theory; Greek prosody, grammar and rhetoric; or any of many other enticing topics.

Working closely with the Iliad also suggests we need terms for the intermediate-size structures. In the medium term the tagging may be free form. This should be considered a feature, not a bug. *I would write on the lintels of the door-post, Whim. I hope it is somewhat better than whim at last, but we cannot spend the day in explanation.* (R W Emerson, "Self-reliance".)

The terms **metron**, **onoma** (word), **stichos** (line), **phalanx**, **stratos**, **rhapsody** could work...?

Comparing the structures of these could be interesting as well. At the level of the phalanx (8-10 lines) and above we see both formula, and much playing around with formula.

### Publication

Already for the Iliad I have developed and published, on the Internet, helper materials for readers. Their main (and so far only) audience is myself.

In order to test out the concepts here, I plan also to produce an *Illuminated Iliad*. It will probably combine HTML, CSS and SVG for a "styled view" not an assisted reader (with vocabulary help etc.)

For comparison, *Eluciated Iliad* is a different rendering of the poem as an assisted reader, with vocabulary help (produced from public domain XML sources, not LMNL markup). See my initiative at raventracks.org.

## Further prospects

Are there further prospects for LMNL? It has evidently done its work and more, for me. Only a hard-hearted person would not be amazed at how much I have received back for making this poor effort, and how much I have learned from everyone I met doing so. An old professor of mine once said of a little story he had written, that he was proud of it the way one is proud of one's idiot child. And yet, LMNL surprises!

-----