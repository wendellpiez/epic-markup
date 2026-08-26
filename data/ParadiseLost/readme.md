
# Paradise Lost (Book I) by John Milton

Demonstrating lightweight LMNL processing.

Just even, possibly, to whet the appetite.

LMNL instances can be made by hand, or produced via automated tagging techniques as shown here.

Once a text is tagged in LMNL it is subject to processing based on those tags. Processes include the extraction of arbitrary ranges. In this demonstration, speeches of devils (Satan once called Lucifer, and Beelzebub) can be extracted from the main narrative of Book I.

## LMNL by extraction.

Run the pipeline [../../run/PRODUCE_PARADISE-LOST_LMNL.xpl](../../run/PRODUCE_PARADISE-LOST_LMNL.xpl) to generate full-fledged LMNL markup of Book I of the epic melodrama by John Milton, the revised edition of 1674. The pipeline reads the [HTML source file in this directory](c0_Paradise_Lost__1674__Book_I.xhtml) and writes a LMNL result file alongside it, [book01_rich.lmnl](book01_rich.lmnl).

'Full-fledged' feathering includes markup for these features and phenomena:

- Verse paragraphs and lines of verse
- Direct quotes as attributed to speakers (`quote` markup)
- Sentence/phrase demarcations

Especially the overlap between the first and last of these structures is interesting.

## The author's intent

Indeed we have Milton's own word that the relation between verse structure and grammatical phrasing matters (in the introductory remarks to the poem, defending blank verse):

> Not without cause therefore some both Italian and Spanish Poets of prime note have rejected Rime both in longer and shorter Works, as have also long since our best English Tragedies, as a thing of it self, to all judicious eares, triveal and of no true musical delight: which consists only in apt Numbers, fit quantity of Syllables, and **the sense variously drawn out from one Verse into another**, not in the jingling sound of like endings, a fault avoyded by the learned Ancients both in Poetry and all good Oratory."

(emphasis added)

## Task list

Stabilize, document and commit file:/C:/Users/wapie/Documents/Github/Laminator/lib/MNML-SURVEY-source.xpl

Next steps:

Document pipelines in ./run folder
Review and document code (XProc and XSLT)
Textpad?

Editing vids (TextPad, Oxygen)
HTML ILIAD ILLUMINATED

Beyond that: subsequent books (for 12 total)? more elaborate markup?

NB - the main technical question is whether and how the iXML grammar parsing `s/phr` structures holds up in the face of new inputs. Other questions hinge on requirements tbd.

## Generalizable rules around English poetry

Given the work here, it is inevitable to wonder at the limits of the approach and in how the words of other poets fare, when we start attending to their work with the buzzsaw of markup that allows overlap.

As just noted, so far we are not providing markup around Milton's rhetorical tropes - similes, comparisons and the rest. It is not difficult to envision.

## Known limits

The grammar provided for inferencing of `s/phr` (sentence/phrase) structures in English is fallible, likely to require adjustment for new inputs.

The data source is a clean copy derived from public (PD) data. It can be switched out for any (plain text or HTML) input, with adjustments.

Adjustments can serve also to make this useful to other workflows in which LMNL may be embedded.

## AI policy

There is no AI policy as we are not using any LLMs or "AI"s (Alien Incursions), broadly defined. This means we do not code or test with AIs. Because the site is on Github, Copilot may occasionally have provided inessential secondary inputs such as commit messages.

Interest in this project from people is most welcome. License terms make it explicit that any reuse of code on this site requires explicit crediting (of the developer and of upstream dependencies, as documented).

## Range maps

TODO: DEVELOP a range map (at least one) for *Paradise Lost*, Book I

-----
-----

