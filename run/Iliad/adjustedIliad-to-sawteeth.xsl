<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:output method="text"/>
  
  
  <xsl:strip-space elements="*"/>
  
  <xsl:preserve-space elements="l"/>
  
  <!-- Uses Laminator copy -->
  <xsl:import href="../../lib/Laminator/lib/common/xml-to-lmnl.xsl"/>

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="l">
    <xsl:for-each select="preceding-sibling::*[1]/self::l">
      <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template match="book" mode="start-tag end-tag">
    <xsl:text>&#xA;</xsl:text>
    <xsl:next-match/>
  </xsl:template>
  
  
  <xsl:template match="q">
    <xsl:text>&#xA;</xsl:text>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template match="milestone" mode="start-tag">
    <xsl:text expand-text="true">&#xA;[{ @unit }</xsl:text>
    <xsl:apply-templates select="@* except (@unit | @ed)" mode="tag"/>
    <xsl:text>}</xsl:text>
  </xsl:template>
  
  <xsl:template match="milestone" mode="end-tag">    
    <xsl:text expand-text="true">{ '{' || @unit }]</xsl:text>
  </xsl:template>
  
  <xsl:template match="milestone[@unit='para']">
    <xsl:apply-templates select="preceding-sibling::milestone[@unit='para'][1]" mode="end-tag"/>
    <xsl:apply-templates select="." mode="start-tag"/>
  </xsl:template>
  
  <!-- was div[@subtype='Book'] -->
  <xsl:template match="book/descendant::l[last()] | div[@subtype='Book']/descendant::l[last()]">
    <xsl:next-match/>
    <xsl:apply-templates select="../descendant::milestone[@unit='para'][last()]" mode="end-tag"/>
  </xsl:template>
  
  <!-- Dropping the end tag in a quote where an end tag is marked -->
  <xsl:template match="q[exists(child::l/END_TAG[@gi='q'])]" mode="end-tag"/>
  
  <!-- Placing an end tag where marked -->
  <xsl:template match="END_TAG" expand-text="true">{{{ @gi }]</xsl:template>
    
  <!-- Candidates for conversion into ranges:
    milestone [@unit='p']    
    add a close {p] at the end
  -->

  
  
</xsl:stylesheet>
