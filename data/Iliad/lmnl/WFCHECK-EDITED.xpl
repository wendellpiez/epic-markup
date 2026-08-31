<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:mnml="http://wendellpiez.com/ns/xMNML" exclude-inline-prefixes="#all" version="3.0">

  <!-- For basic wf testing of all files contained in 'edited' dir -->
  
  <p:import href="../../../lib/Laminator/lib/xMNML/in/sawtooth-syntax/mnml-lmnl_wf-check.xpl"/>
  
  <p:output port="result" serialization="map{ 'indent': true() }"/>

  <!-- . .. .  . .. .  . .. .  . .. .  . .. .  . .. .  . .. .  . .. .  . .. .  . .. .  . .. .  -->

  <p:directory-list path="edited"/>

  <p:for-each name="testing">
    <p:with-input select="//c:file"/>

    <!--ITERATING OVER LMNL SOURCES -->
    <p:variable name="fileURI" select="resolve-uri( /*/@name, base-uri(.) )"/>

    <p:load content-type="text/plain" href="{ $fileURI }"
      message="LOADING { tokenize($fileURI,'/')[last()] } to check syntax --"/>

    <!-- By default, permits nesting to 1000 levels
         set levels="20" to lower this threshold -->
    <mnml:mnml-lmnl_wf-check name="wf-check"/>

    <!-- inserting test report WHEE or OOPS -->
    <p:insert position="first-child">
      <p:with-input port="insertion" pipe="report@wf-check"/>
    </p:insert>

    <p:add-attribute match="okay[child::OOPS]" attribute-name="BUT" attribute-value="NOT_OKAY"/>
    <p:add-attribute match="broke[child::WHEE]" attribute-name="BUT" attribute-value="SAYS_OKAY"/>
    <p:delete match="/*/*/text()"/>
    <p:delete match="@file"/>

  </p:for-each>

  <p:wrap-sequence wrapper="REPORT"/>

</p:declare-step>
