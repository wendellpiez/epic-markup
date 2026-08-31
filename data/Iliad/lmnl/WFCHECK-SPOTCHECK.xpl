<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:mnml="http://wendellpiez.com/ns/xMNML" exclude-inline-prefixes="#all" version="3.0">

  <!-- Spot check a single file or files on the 'input' port as text/plain (LMNL) -->
  
  <p:import href="../../../lib/Laminator/lib/xMNML/in/sawtooth-syntax/mnml-lmnl_wf-check.xpl"/>
  
  <p:output port="report" primary="true" serialization="map{ 'indent': true() }"
    pipe="report@wf-check"/>

  <p:output port="result" serialization="map{ 'indent': true() }" sequence="true"
    pipe="@reported-errors"/>

  <!-- ^.^ _~_ ^.^ _~_ ^.^ _~_ ^.^ _~_ ^.^ _~_ ^.^ _~_ ^.^ _~_ ^.^ _~_ ^.^ _~_ ^.^ _~_ -->

  <p:input port="source">
    <!--<p:document content-type="text/plain" href="edited/book01.lmnl"/>-->
    <!--<p:document content-type="text/plain" href="edited/book02.lmnl"/>-->
    <p:document content-type="text/plain" href="edited/book03.lmnl"/>
  </p:input>

  <mnml:mnml-lmnl_wf-check name="wf-check"/>

  <!-- inserting test report WHEE or OOPS -->
  <p:filter select="/*/c:errors" name="reported-errors">
    <p:with-input port="source" pipe="result@wf-check"/>
  </p:filter>

  <!--<p:identity>
    <p:with-input port="source" pipe="result@wf-check"/>
  </p:identity >-->



</p:declare-step>
