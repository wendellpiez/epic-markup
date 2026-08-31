# Some Background on LMNL

(retrospective August 2026)

XML was published in late 1998. By 2002 we suddenly had many new tools: HTML and CSS were bringing us declarative markup and layered styling on the web; browser developers were beginning to provide DOM access to pages and their structures; and above all, XML made it possible (as a friend of once mine said) "never to have to write a parser again". (It turns out he was wrong, but he was right before he was wrong -- and now he is right again.)

One of the new ideas of 2002 -- even then, an old idea given new dress -- was LMNL, a markup language and syntax developed and proposed by Jeni Tennison and myself. LMNL was inspired directly by the work of Gavin Thomas Nicol on range algebras. We took his idea of capturing a text into ranges, where ranges consisted of contiguous runs of characters, and abstracted this into a conceptual model of a document as a set of ranges defined over a text. (In some ways Nicol's range algebra was like iXML before its time.) Indirectly, the inspiration for LMNL was XML itself, specifically as a refinement of SGML: like XML (and SGML), LMNL sought to be *generalized*; like XML (and unlike SGML) LMNL made a clear distinction between its syntax of representation (markup as syntax and notation, tags and text), and its data model.

Over the course of some years, LMNL subsisted as a research project in the form of a standards development exercise, while we (proponents) wrote papers on or around it, and while others made and demonstrated proposed solutions of their own, to the set of problems LMNL was aimed at. The problem set, of course, goes by the name of "Overlap".

As described at the [First International Symposium on iXML](https://invisiblexml.org/events/symposium2026/#slides)([with paper](https://github.com/wendellpiez/Laminator/tree/main/papers/iXMLSymposium2026)), the story then seemed over, until it didn't. Better tools in the XML stack had eased the problems of developers designing for and supporting a familiar set of overlap-related requirements. But then seemingly at once, the doors opened again to a viable implementation of a LMNL processing stack, using XProc, iXML and XSLT 3.0. I undertook this project (my second LMNL processor) in late 2025: the **Laminator**.

During this period I learned from everyone else who also looked at the beast. Many of their initiatives and proposed solutions are reflected in the work being offered. Similarly, many of the XML "usual tricks" around overlap -- milestones, segmenting, standoff -- can be readily accommodated by the Laminator as inputs and in its (XML) productions.

---