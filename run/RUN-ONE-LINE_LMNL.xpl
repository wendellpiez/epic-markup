<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:mnml="http://wendellpiez.com/ns/xMNML"
  xmlns="http://wendellpiez.com/ns/xMNML"
  xmlns:EPIC="https://github.com/wendellpiez/EpicMarkup/ns"
  exclude-inline-prefixes="#all">

  <!--
    Purpose: show a single instance processed, in miniature
    
  -->
  
  <p:import href="../lib/Laminator/lib/parse_mnml-lmnl.xpl"/>

  <p:input port="source" expand-text="false">
    <p:inline content-type="text/plain">[l [n}4.439{]}ὄρσε δὲ τοὺς μὲν [nom}Ἄρης{nom], τοὺς δὲ [ep}γλαυκῶπις [nom}Ἀθήνη{nom]{ep]{l]</p:inline>
  </p:input>
  
  <p:output port="result" primary="true" serialization="map { 'indent': true() }"/>
  
  <p:output port="LAYERS" serialization="map { 'indent': true() }" sequence="true"
    pipe="LAYERS@parsed_LMNL"/>
  
  <p:output port="xMNML" serialization="map { 'indent': true() }" sequence="true"
    pipe="xMNML@parsed_LMNL"/>
  
  <mnml:parse_mnml-lmnl name="parsed_LMNL"/>
    
  <!--<p:delete match="mnml:*[@gi='ep']"/>-->
  
  <p:xslt>
    <p:with-input port="stylesheet" href="../lib/Laminator/lib/xMNML/out/xMNML-xml-ripper.xsl"/>
  </p:xslt>
  
  
    <!-- NEXT: filter ranges and 'rip' two XML documents, one l/nom and one l/ep -->
   
</p:declare-step>