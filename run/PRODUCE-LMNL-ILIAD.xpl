<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:EPIC="https://github.com/wendellpiez/EpicMarkup/ns" xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0" exclude-inline-prefixes="#all">

  <!-- Purpose: From downloaded PerseusDL source data:

    Produce a LMNL-encoded version (in a TEI wrapper, with metadata)
    Produce LMNL versions - both extracted, and revised and enhanced
    
    This XProc executes in 32 sec in oXygen 28.1, but only 12 sec
    when run from the CLI using a recent XML Calabash (script calling Java)
    
  -->
  
  <p:import href="Iliad/epic-markup.xpl"/>

  <!-- Use pipeline ../Sources/ACQUIRE_PerseusDL-TEI.xpl to acquire a copy -->
  <p:input port="source" href="../Sources/PerseusDL/tlg0012.tlg001.perseus-grc2.xml"/>

  <p:delete match="/processing-instruction()"/>
  <p:identity name="PerseusDL-TEI"/>

  <p:viewport match="/TEI/text/body/div/div" name="each_book">
    <p:variable name="book00" select="p:iteration-position() => format-number('00')"/>

    <p:delete match="l//text()[normalize-space(.) => not()]"/>
    <p:xslt name="lmnlizer">
      <p:with-input port="stylesheet" href="../lib/Laminator/lib/common/xml-to-lmnl.xsl"/>
    </p:xslt>

    <p:text-replace pattern="^\s+" replacement="" flags="m"/>
    <p:variable name="lmnl" select="."/>

    <!-- SAVES a fresh LMNL version in folder ../data/Iliad/lmnl/generated/PerseusDL_src -->
    <EPIC:store href="../data/Iliad/lmnl/generated/PerseusDL_src/book{ $book00 }.lmnl"
      hint="PerseusDL source, encoded in LMNL"/>

    <p:delete match="/*/node()">
      <p:with-input port="source" pipe="current@each_book"/>
    </p:delete>
    <p:insert match="/*" position="first-child">
      <p:with-input port="insertion" expand-text="true">
        <ab>{ $lmnl }</ab>
      </p:with-input>
    </p:insert>
  </p:viewport>

  <EPIC:teiHeader_update/>

<!-- Now saving a 'nominal' TEI version with updated header and LMNL as a text brick.
     NB adjustments to the header can be made in the subpipeline-->

  <EPIC:store href="../data/Iliad/tei/PerseusDL_lmnl-tei.xml"
    hint="PerseusDL TEI, with books in LMNL syntax"/>

  <!--Next going back to source and making a few adjustments to XML source
      for cleaner mapping -->

  <p:xslt>
    <p:with-input port="source" pipe="result@PerseusDL-TEI"/>
    <p:with-input port="stylesheet" href="Iliad/perseus-Iliad-fixup.xsl"/>
  </p:xslt>
  
  <!-- Result is comparable not to LMNL but to the original input -->
  <EPIC:store href="../data/Iliad/tei/ILIAD_epicmarkup_tei.xml" hint="TEI, with adjustments"/>
  
  <!-- Further tailored modifications for this data -->
  <p:xslt name="adjusted">
    <p:with-input port="stylesheet" href="Iliad/perseus_Iliad-adjust.xsl"/>
  </p:xslt>
  
  <!-- Writing LMNL notation now -->
  <p:xslt>
    <p:with-input port="stylesheet" href="Iliad/adjustedIliad-to-sawteeth.xsl"/>
  </p:xslt>

  <!-- Full text, in LMNL -->
  <EPIC:store href="../data/Iliad/lmnl/generated/ILIAD_pages.lmnl" hint="LMNL, improved"/>

  <!-- Again, except this time each book -->
  <p:for-each>
    <p:with-input select="//EPIC/book" pipe="result@adjusted"/>
    <p:variable name="book00" select="p:iteration-position() => format-number('00')"/>
    
    <p:xslt>
      <p:with-input port="stylesheet" href="Iliad/adjustedIliad-to-sawteeth.xsl"/>
    </p:xslt>
    <EPIC:store href="../data/Iliad/lmnl/generated/enhanced/book{ $book00 }.lmnl" hint="LMNL, with enhancements"/>
  </p:for-each>

</p:declare-step>