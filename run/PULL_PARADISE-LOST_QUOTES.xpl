<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:mnml="http://wendellpiez.com/ns/xMNML"
  xmlns:c="http://www.w3.org/ns/xproc-step" version="3.0">

  <!-- NEXT: GENERALIZE FOR ANY BOOK (doing only Book I) -->
  <p:import href="../lib/Laminator/lib/xMNML/in/sawtooth-syntax/sawteeth-to-xMNML.xpl"/>

  <!--<p:output port="reports" serialization="map { 'indent': true() }"/>-->

  <!-- Bound by default to the referenced LMNL document; any other can be
       provided (as text/plain)
  Note that the XSLT is hard coded to this instance so YMMV
  adjustments may be called for on other inputs
  -->

  <p:input port="source" sequence="true">
    <p:document content-type="text/plain" href="../data/ParadiseLost/edited/book01_rich_numbered.lmnl"/>
  </p:input>

  <p:declare-step type="mnml:extract-quotes">
    <p:input port="source" content-types="text/plain"/>
    <p:output port="result" content-types="application/xml"/>

    <p:option name="range-types" select="'quote'"/>

    <mnml:sawteeth-to-xMNML name="xMNML"/>
    <p:xslt parameters="map { 'range-types': $range-types }">
      <p:with-input port="stylesheet" href="ParadiseLost/extract-with-lines.xsl"/>
    </p:xslt>
  </p:declare-step>

  <p:variable name="basename" select="base-uri(/) => replace('(.*/|\.lmnl$|-xMNML\.xml$)','')"/>

  <mnml:extract-quotes range-types="quote"/>
  <p:add-attribute match="/*" attribute-name="id" attribute-value="{ $basename }"/>

  <p:wrap-sequence wrapper="EXTRACTS"/>

  <p:namespace-rename apply-to="elements" to="http://wendellpiez.com/ns/xMNML"/>

  <p:store href="../data/ParadiseLost/cache/{ $basename }_quotes.xml"
    serialization="map{ 'indent': true() }"
    message="-- Stored a quotes collection in file ../data/ParadiseLost/cache/{ $basename }_quotes.xml"/>

</p:declare-step>