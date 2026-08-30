<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="#all" expand-text="true" version="3.0">

  <xsl:variable static="true" name="noisy" select="false()"/>

  <xsl:mode on-no-match="shallow-copy" on-multiple-match="fail"/>

  <!-- Further adjustments for clean LMNL - nb no longer fully TEI conformant!-->
<!--
  - extracts full text (body/div) from larger file
  - body/div becomes EPIC, body/div/div becomes EPIC/book 
  - l/@n expanded to include book no
  - @who and @toWhom added to quotes based on lookup
  - milestone <milestone type="ENDTAG-q"/> inserted into a q element,
      priming repair in LMNL-write phase
    
    other strategies for markup:
      inferencing for epithets (based on a list)
  
  -->
  <xsl:template match="div[@type='edition']">
    <EPIC>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates/>
    </EPIC>
  </xsl:template>
  
  <xsl:template match="@type | /*/@n"/>
  
  <xsl:template match="div[@subtype='Book']">
    <book>
      <xsl:apply-templates select="@n"/>
      <xsl:apply-templates/>
    </book>
  </xsl:template>

  <xsl:template match="l/@n">
    <xsl:attribute name="n">{ parent::l/ancestor::div[1]/@n || '.' || . }</xsl:attribute>
  </xsl:template>
  
  <!--  <l n="70">ἐκ Διός· ἀλλὰ σὺ σῇσιν ἔχε φρεσίν· ὣς ὃ μὲν εἰπὼν</l> -->

  <!-- For intervention in the next step -->
  <xsl:template match="div[@n='2']//l[@n='70']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:variable name="trailer" select="' ὣς ὃ μὲν εἰπὼν'"/>
      <xsl:value-of select="substring-before(.,$trailer)"/>
      <END_TAG gi="q"/>
      <xsl:value-of select="$trailer"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>

