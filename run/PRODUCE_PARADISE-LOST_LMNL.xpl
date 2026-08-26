<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:EPIC="https://github.com/wendellpiez/EpicMarkup/ns"
  xmlns:mnml="http://wendellpiez.com/ns/xMNML" exclude-inline-prefixes="#all">


  <!-- 
    
    Purpose: From downloaded WikiData source:

Produce LMNL sample data results
combining three OHCO structures:
  vp/line (shown as TEI lg/l)
  s/phr
  quote (quoted speeches)

The pipeline emits LMNL syntax suitable for further processing

It can be corrected and amended by hand.

We can also make cleaner (subsetted) LMNL, when wanted.

Or use this pipeline as the first step in a larger orchestration
of edits and enhancements.

Plain text processing over LMNL syntax is a thing! b/c attributes do not reorder
This makes it much more robust than XML under regular expressions.

Or work directly with the LAYERS or intermediate xMNML representations of the same data.

(Each has its advantages.)

Here, we start with Paradise Lost Book I.

But the process should be repeatable across the 12 books

1. Extract HTML from EPUB
2. Clean up (minor) and flatten into a single XML element with plain text (uhuh)
3. Brute-force 'quote' tagging as s/r for quote marks (regex)
4. Parse to produce an XML marking quotes (only), enhance and save it
5. Save back down to plain text
6. Pass through an XSLT to group lines into lg/l and save it
7. Pass plain text again, this time through an iXML grammar for s/phr structure
8. Combine these three trees into single xMMNL LAYERS instance
9. First three different LAYERS/layer, then consolidate into a single
9. Spiff up and validate
10. From this LAYERS instance produce an xMNML serialization
11. From the flat xMNML tag-and-text stream, write LMNL (sawteeth) notation

The resulting LMNL is not perfect, mainly because the grammar (step 7)
does not deliver perfect results. But the results are also easily corrigible.

  -->

  <!-- When wanted to go all the way back to the downloaded EPUB -->
  <!--<p:import href="ParadiseLost/EPUB-EXTRACTION.xpl"/>-->
  <p:import href="ParadiseLost/English_s-phr_tagger.xpl"/>
  
  <p:import href="ParadiseLost/PL-quotes_tagger.xpl"/>
  
  <p:import href="ParadiseLost/merge-xml-layers.xpl"/>

  <p:import href="../lib/Laminator/lib/LAYERS/out/layers-xMNML-build.xpl"/>


  <p:option name="caching" as="xs:boolean" static="true" select="true()"/>

  <p:option name="cache-dir" as="xs:string" select="'cache'"/>
  
  <!-- This file can be extracted by running EPUB-EXTRACTION (standalone) -->
  <p:load href="../Sources/Wikisource/c0_Paradise_Lost__1674__Book_I.xhtml"
    content-type="application/xhtml+xml"/>

  <p:group xmlns="http://www.w3.org/1999/xhtml">
    <p:filter select="/html/body/section/div/p"/>

    <p:delete match="span[empty(* except sup)]"/>

    <!--quick n dirty -->
    <p:string-replace match="text()" replace="replace(.,'\n\s+','&#xA;')"/>

    <!-- padding mdash with spaces makes things much easier -->
    <p:string-replace match="text()" replace="replace(.,'—','— ')"/>

    <!--<p:string-replace match="text()" replace="replace(.,':— ',':—')"/>-->

    <p:unwrap match="p//*"/>

    <p:rename match="/p" new-name="BOOK"/>

    <p:identity name="raw_XML"/>
    <p:store use-when="$caching" href="../data/ParadiseLost/{ $cache-dir }/book01_RAW.xml"
      message="STORING ../data/ParadiseLost/{ $cache-dir }/book01_RAW.xml"/>
  </p:group>

  <!--Evil way to promote quotes to tags -->

  <p:variable name="quotes-match-regex" select="string(.)">
    <p:inline>"([^"]+)"</p:inline>
  </p:variable>

  <!-- next up - tag writing! We used to tell new students never never do this
   but that was in XSLT where that is still good advice -->
  <p:variable name="quotes-replace-expr" select="string(.)">
    <p:inline>&lt;quote>$1&lt;/quote></p:inline>
  </p:variable>

  <!-- WHEE! -->
  <p:viewport match="BOOK/text()">
    <p:variable name="marked-up" select="replace(., $quotes-match-regex, $quotes-replace-expr)"/>
    <p:identity>
      <p:with-input select="$marked-up => parse-xml-fragment()"/>
    </p:identity>
  </p:viewport>

  <!-- Enhancements assigning (known) speakers to the quotes -->
  <EPIC:PL-quotes_tagger/>
  
  <!-- ### CAPTURE -->
  <p:identity name="marked-quotes_XML"/>

  <p:store name="marked-quotes" use-when="$caching"
    href="../data/ParadiseLost/{ $cache-dir }/book01_QUOTES.xml"
    message="STORING ../data/ParadiseLost/{ $cache-dir }/book01_QUOTES.xml"/>

  <!-- Now we have quotes safely marked, we strip them again to pass the quote-free text
       into the next inductor -->
  <p:unwrap match="quote"/>

  <!-- ### CAPTURE (probably not needed) -->
  <p:identity name="blank_XML"/>

  <p:store use-when="$caching" href="../data/ParadiseLost/{ $cache-dir }/book01_BLANK.xml"
    message="STORING ../data/ParadiseLost/{ $cache-dir }/book01_BLANK.xml"/>

  <p:store use-when="$caching" href="../data/ParadiseLost/{ $cache-dir }/book01.txt"
    serialization="map { 'method': 'text' }" message="STORING ../data/ParadiseLost/{ $cache-dir }/book01.txt"/>

  <!-- Next up: producing verse-paragraph and line markup -->

  <!-- Next p: XSLT this into vp/line structure -->
  <p:xslt>
    <p:with-input port="stylesheet" href="ParadiseLost/split_vp-lines.xsl"/>
  </p:xslt>

  <p:viewport match="/BOOK/*/line">
    <p:label-elements attribute="n" label="{ p:iteration-position() }"/>
  </p:viewport>

  <!-- Inserting LF back for legibility (ws being discarded in grouping) -->
  <p:insert match="lg[position() gt 1] | l" position="before">
    <p:with-input port="insertion">
      <p:inline>&#xA;</p:inline>
    </p:with-input>
  </p:insert>

  <p:store use-when="$caching" href="../data/ParadiseLost/{ $cache-dir }/book01_LINES.xml"
    message="STORING ../data/ParadiseLost/{ $cache-dir }/book01_LINES.xml"/>

  <!-- ### CAPTURE -->
  <p:identity name="vp-lines_XML"/>

  <!-- Next we pass the string value of the BOOK into an iXML parse
       to elicit the sentence/phrase structure -->
  <!-- ### CAPTURE -->
  <EPIC:English_s-phr_tagger name="phrased_XML">
    <p:with-input port="source" select="string(/*)"/>
  </EPIC:English_s-phr_tagger>

  <p:store use-when="$caching" href="../data/ParadiseLost/{ $cache-dir }/book01-PHRASED.xml"
    message="STORING ../data/ParadiseLost/{ $cache-dir }/book01-PHRASED.xml"/>

  <!-- a formality -->
  <p:sink/>
  
  <!-- Now using the xMNML namespace on unprefixed element names -->
  <p:group xmlns="http://wendellpiez.com/ns/xMNML">

    <!-- Picking up and unifying our strands (three OHCOs) -->
    <mnml:merge-xml-layers name="MERGED">
      <p:with-input port="source">
        <p:pipe step="vp-lines_XML"/>
        <p:pipe step="marked-quotes_XML"/>
        <p:pipe step="phrased_XML"/>
      </p:with-input>
    </mnml:merge-xml-layers>

    <p:store use-when="$caching" href="../data/ParadiseLost/{ $cache-dir }/book01_ALL-LAYERS.xml"
      serialization="map { 'indent': true() }"
      message="STORING ../data/ParadiseLost/{ $cache-dir }/book01_ALL-LAYERS.xml"/>

    <!--Now some adjustment: remove redundant BOOK and RUN ranges;
  push through a unifier (rewiring IDs)
  then serialize into xMNML and LMNL 
  -->

    <!-- Absolute paths help the XProc engine -->
    <p:delete match="/*/layer[contains-token(@ranges, 'quote')]/range[@gi='BOOK'] |
                     /*/layer/range[@gi='RUN']"/>

    <!-- Merging ~~~ -->
    <p:xslt>
      <p:with-input port="stylesheet" href="../lib/Laminator/lib/LAYERS/out/merge-layers.xsl"/>
    </p:xslt>

    <p:store use-when="$caching" href="../data/ParadiseLost/{ $cache-dir }/book01_UNIFIED-LAYER.xml"
      serialization="map { 'indent': true() }"
      message="STORING ../data/ParadiseLost/{ $cache-dir }/book01_UNIFIED-LAYER.xml"/>

  </p:group>

  <!-- We have LAYERS, we can have xMNML and tags too -->
  <mnml:layers-xMNML-build name="xMNML_build"/>

  <p:store use-when="$caching" href="../data/ParadiseLost/{ $cache-dir }/book01_UNIFIED-xMNML.xml"
    serialization="map { 'indent': true() }"
    message="STORING ../data/ParadiseLost/{ $cache-dir }/book01_UNIFIED-xMNML.xml"/>

  <!-- Always writing LMNL out even when not $caching interim results -->
  <p:store href="../data/ParadiseLost/book01_rich.lmnl"
    serialization="map { 'method': 'text', 'omit-xml-declaration': true() }"
    message="STORING ../data/ParadiseLost/book01_rich.lmnl">
    <p:with-input pipe="sawteeth@xMNML_build"/>
  </p:store>

</p:declare-step>
