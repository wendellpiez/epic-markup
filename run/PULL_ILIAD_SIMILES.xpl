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
    <p:document content-type="text/plain" href="../data/Iliad/lmnl/edited/book04.lmnl"/>
  </p:input>

  <p:declare-step type="mnml:extract-quotes">
    <p:input port="source" content-types="text/plain"/>
    <p:output port="result" content-types="application/xml"/>

    <p:option name="range-types" select="'quote'"/>

    <mnml:sawteeth-to-xMNML name="xMNML"/>
    <p:xslt parameters="map { 'ranges': tokenize($range-types,'\s+') }">
      <p:with-input port="stylesheet" href="Iliad/extract-with-lines.xsl"/>
    </p:xslt>
  </p:declare-step>

  <p:variable name="basename" select="base-uri(/) => replace('(.*/|\.lmnl$|-xMNML\.xml$)','')"/>

  <mnml:extract-quotes range-types="simile trope"/>
  <p:add-attribute match="/*" attribute-name="id" attribute-value="{ $basename }"/>

  <p:wrap-sequence wrapper="EXTRACTS"/>

  <p:namespace-rename apply-to="elements" to="http://wendellpiez.com/ns/xMNML"/>

  <p:store href="../data/Iliad/cache/{ $basename }_similes.xml"
    serialization="map{ 'indent': true() }"
    message="-- Stored a similes collection in file ../data/Iliad/cache/{ $basename }_similes.xml"/>

</p:declare-step>