<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:mnml="http://wendellpiez.com/ns/xMNML"
  xmlns:EPIC="https://github.com/wendellpiez/EpicMarkup/ns"
  exclude-inline-prefixes="#all">

  <!-- Purpose: Produce MYTHOI range maps in SVG
    from LMNL in provided folder
    
    defaults to the 'edited' folder but you can opt for a different one for comparison
    
  -->
  
  <p:import href="../lib/Laminator/lib/parse_MNML-LMNL.xpl"/>

  <p:option name="lmnl-dir" select="'edited'"/>
  
  <!--<p:output port="result" serialization="map { 'indent': true() }" sequence="true"/>-->
  
  <p:variable name="target-dir" select="'../data/Iliad/lmnl/' || $lmnl-dir"/>  

  <p:directory-list path="{$target-dir}" include-filter="\.lmnl$"/>
  
  <p:for-each>
    <p:with-input select="/c:directory/c:file"/>
    <p:variable name="filepath" select="/*/@name => resolve-uri(base-uri(.))"/>
    <p:variable name="svg-name" select="tokenize($filepath,'/')[last()] ! replace(.,'lmnl$','svg')"/>
    <p:variable name="bookN" select="replace($svg-name,'\D','') => number()"/>
    <p:variable name="svg-path" select="('../data/Iliad/rangemaps', $lmnl-dir, $svg-name) => string-join('/')"/>
    
    <p:load href="{ $filepath }" content-type="text/plain"/>
    
    <mnml:parse_mnml-lmnl/>
    
    <p:xslt message="Producing { $svg-name } at path { $svg-path } ..."
      parameters="map { 'bookNo': $bookN }">
      <p:with-input port="source" pipe="LAYERS"/>
      <p:with-input port="stylesheet" href="Iliad/mythoi-svg-rangemap.xsl"/>
    </p:xslt>
    
    <!-- TODO: an XSLT to do even more to help the SVG -->
    <p:string-replace match="@d | @width | @height"
      replace="tokenize(.,'\s+') ! (if (. castable as xs:decimal) then round(number(.),3) else .) "/>
    
    <p:store href="{ $svg-path}" serialization="map { 'indent': true() }"/>
  </p:for-each>
    
</p:declare-step>