<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://wendellpiez.com/ns/xMNML"
  xpath-default-namespace="http://wendellpiez.com/ns/xMNML" exclude-result-prefixes="#all"
  version="3.0">

  <!-- Interesting range types: 's' (sentence), 'quote' (noun phrase)
         and (yes) 'l' (line)
    
    This XSLT is meant to be used on verse or at any rate on texts marked with 'line' ranges! -->

  <!-- Override with strings for different range types -->
  <xsl:param name="ranges" select="'quote'" as="xs:string*"/>

  <xsl:key name="text-for-range" match="text" use="tokenize(@cf, '\s+')"/>

  <xsl:key name="range-for-text" match="start" use="@rID"/>

  <xsl:template match="/*">
    <REPORT ranges="{ string-join($ranges,' ') }">
      <xsl:apply-templates select="start[@gi = $ranges]"/>
    </REPORT>
  </xsl:template>

  <xsl:template match="start" expand-text="true">
    <!-- $ll is all 'l' ranges covered by text in this range -->
    <xsl:variable name="lines"
      select="key('text-for-range', @rID)/key('range-for-text', tokenize(@cf, ' '))[@gi = ('l', 'line')]"/>
    <xsl:variable name="where">
      <xsl:value-of select="($lines[1], $lines[last()])/annotation[@gi = 'n']" separator="-"/>
    </xsl:variable>
    <xsl:element name="{ @gi }" namespace="http://wendellpiez.com/ns/xMNML">
      <!-- we add @l for a single line, @ll for a range of lines -->
      <xsl:attribute name="l{$lines[2]/'l'}" select="$where"/>
      <xsl:for-each-group select="annotation" group-by="@gi">
        <xsl:attribute name="{ current-grouping-key() }" select="current-group() => string-join(' ')"/>  
      </xsl:for-each-group>      
      <xsl:text>{ key('text-for-range',@rID) => string-join() => replace('&#xA;',' / ') }</xsl:text>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>