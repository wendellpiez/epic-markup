<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:mnml="http://wendellpiez.com/ns/xMNML"
  xmlns="http://wendellpiez.com/ns/xMNML"
  xmlns:EPIC="https://github.com/wendellpiez/EpicMarkup/ns"
  exclude-inline-prefixes="#all">

  <!--
    Purpose: Produce tagging surveys of LMNL
    
    defaults to the 'edited' folder but you can opt for a different one for comparison
    
  -->
  
  <p:import href="../lib/Laminator/lib/parse_mnml-lmnl.xpl"/>

  <p:option name="lmnl-dir" select="'edited'"/>
  
  <p:output port="result" serialization="map { 'indent': true() }" sequence="true"/>
  
  <p:variable name="target-dir" select="'../data/Iliad/lmnl/' || $lmnl-dir"/>  

  <p:directory-list path="{$target-dir}" include-filter="\.lmnl$"/>
  
  <p:for-each>
    <p:with-input select="/c:directory/c:file"/>
    <p:variable name="filepath" select="/*/@name => resolve-uri(base-uri(.))"/>
    <p:variable name="bookN" select="replace(tokenize($filepath,'/')[last()],'\D','') => number()"/>
    
        <p:load href="{ $filepath }" content-type="text/plain"/>
    
    <mnml:parse_mnml-lmnl/>
    
    <p:identity>
      <p:with-input port="source" pipe="LAYERS"/>
    </p:identity>
    
    <p:xslt message="Assessing Book { $bookN } ..."
      parameters="map { 'bookNo': $bookN }">
      
      <p:with-input port="stylesheet" href="src/mythoi-range-assessment.xsl"/>
    </p:xslt>
    
    <!--Now in namespace https://github.com/wendellpiez/EpicMarkup/ns-->
    
    <!-- TODO: an XSLT to do even more to help the SVG -->
    <!--<p:string-replace match="@d | @width | @height"
      replace="tokenize(.,'\s+') ! (if (. castable as xs:decimal) then round(number(.),3) else .) "/>-->
    
    
  </p:for-each>
    
  <p:wrap-sequence wrapper="EPIC"/>
  <p:namespace-rename apply-to="elements" to="https://github.com/wendellpiez/EpicMarkup/ns"/>
  
  <p:store href="temp/epic-assessment.xml" serialization="map{ 'indent': true() }"/>
  
  <p:xslt message="Reporting assessment ...">
    <p:with-input port="stylesheet" href="src/mythoi-range-report.xsl"/>
  </p:xslt>
  
  <!--<p:store href="temp/epic-layers.xml"/>-->
  <p:store href="temp/epic-report.xml" serialization="map{ 'indent': true() }"/>
  
</p:declare-step>