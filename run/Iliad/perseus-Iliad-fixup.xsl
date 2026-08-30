<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="#all" expand-text="true" version="3.0">

  <xsl:variable static="true" name="noisy" select="false()"/>

  <xsl:mode on-no-match="shallow-copy" on-multiple-match="fail"/>

  <xsl:mode name="replace" on-no-match="shallow-copy" on-multiple-match="fail"/>

  <xsl:template match="comment()"/>

  <!-- not needed for this application -->
  <xsl:template match="milestone[@unit = 'card']" mode="replace"/>

  <!-- normalizing with others -->
  <xsl:template match="milestone[@unit = 'Para']" mode="replace">
    <milestone ed="P" unit="para"/>
  </xsl:template>

  <xsl:template match="milestone" mode="replace">
    <milestone ed="P" unit="para"/>
  </xsl:template>

  <xsl:template match="l[milestone]" priority="101">
    <!-- Since they happen to come first, nothing is rearranged by placing them
         before, not inside the line -->
    <xsl:apply-templates select="milestone" mode="replace"/>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="milestone"/>

  <xsl:template match="teiHeader//notesStmt/note/text()">
    <xsl:text>{ normalize-space(.) }</xsl:text>
  </xsl:template>
  
  <xsl:template match="l/text()[not(normalize-space())][exists(following-sibling::milestone)]"/>
  
</xsl:stylesheet>