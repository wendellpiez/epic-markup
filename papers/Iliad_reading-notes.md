# Iliad Reading Notes

This is *not* a diary although it may take the form of one.

The difference is that we don't plan to revise a diary while we write it, and this resource will either be revised constantly, or stale and reflective of when it was last touched. We need to revise because we aim to summarize in brief, not to record the discovery process.

No LLMs are being used for any part of the reading and noting here.

## How this happened

In Spring 2026 I started transcribing the Iliad (following the Scriptorium Method) in a series of daily exercises. This happened at the same time as new technologies make LMNL (as conceived in earlier work by myself and others) much more feasible. (LMNL was first conceived twenty years prior to XProc 3.0 and Invisible XML.) The activities of working with Homer and of tagging with LMNL combine into the current effort.

At time of writing I have transcripts of books 1-4 and I'm working my way through Book 5. Much remains, probably at least two years' worth. 

## What are we learning

Structure of the poem - "shagginess"

Levels of scale - zooming in and out (famous for the 'long view')

Units of composition of the poem? metron, line (stichos), phalanx, stratos, rhapsodia.

Oral performance : singing, gesture? turn-taking

Which parts (pieces) might belong to a prior Homer (or a line of them) and which parts only to a late Homer?

Even if we can't say this, can we say which parts and pieces are *necessary* to the famous plot of the Iliad?

At low level (word and morpheme) Greek exhibits the same kind of "grammar of combination" as it does at the phrase and sentence level.

Paragraps `para` ranges interpolated from upstream (PerseusDL) might be removed entirely in favor of a phalanx/stratos grouping.

Phalanges / stratoi - how many are 'portable'

Which ones are clearly "by Homer"?

The fact that LMNL is so permissive means that individual researchers can have their own Iliads.

### Phenomena of interest

- Addressing the reader, or a character, in 2nd person.
  - "You would not think"
  - "Menelaos, you are so lucky"

- Speeches inside speeches

- Death scenes and their variations
    slayer, slain, weapons, body parts
    *pathoi*
    [teuxa}{teuxa] [guia}{guia]

- How do we know what is really Homer (irony? similes? seams between passages?)

- Characters using epithets or other attributes of epic language?

- Idioms?

## LMNL and document engineering

One planned outcomes will be the production of a web-based edition. An open question is whether and to what extent starting from LMNL markup either saves us effort, or increases our leverage in rendering these ambiguous structures in HTML results (where overlap must be hidden, typically using segmentation).

### LMNL Documents and their text values

The text value or 'frontier' is an intrinsic property of a LMNL document, as of a LMNL annotation in full (not MNML) LMNL.

Indeed, it is reasonable to consider two separate LMNL instances, which have the same frontier (as a string of Unicode characters in a given ordre), as two different variants of the same document, since they can be so easily combined into a single LMNL instance, which can be produced by serializing the union of the two range sets over the (common) frontier.

This characteristic also leads to two interesting findings:

(a) a 'checksum' or the functional equivalent can be provided for any LMNL document as a hash value of its frontier. Two LMNL documents with the same hash, can be unified freely. If a document's frontier is altered, the change is detectable by comparing a prior with a current hash value.

(b) LMNL demonstrates better than XML does the truth of Alan Renear's claim that "documents cannot be edited". In effect, the paradox is moved out a layer, since we can conceive of a document as the same (as long as the string value is constant) even when the ranges attributed to it or projected over it, have changed. Only its string value - an abstraction - is identified with the document as such, while the ranges are extrinsic and relative.


