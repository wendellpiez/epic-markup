<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="3.0" name="hello">

  <p:output port="result" serialization="map{ 'omit-xml-declaration': true(), 'indent': true() }"/>

  <p:identity message="RUNNING Hello World smoke test ...">
    <p:with-input>
      <SUCCESS>
        <greeting>Hello world!</greeting>
        <signed>{ p:system-property('p:product-name') } { p:system-property('p:product-version')           }</signed>
      </SUCCESS>
    </p:with-input>
  </p:identity>

</p:declare-step>
