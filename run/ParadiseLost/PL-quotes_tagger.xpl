<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  version="3.0"
   exclude-inline-prefixes="#all"
   xmlns:EPIC="https://github.com/wendellpiez/EpicMarkup/ns"
   type="EPIC:PL-quotes_tagger">
    
    <!--
  Enhances an XML representation of Paradise Lost
  with prior knowledge of the narrative
    -->
  
  <p:input port="source"/>

  <p:output port="result"/>

  <p:add-attribute attribute-name="who" attribute-value="Satan"
    match="quote[starts-with(.,'If thou beest he—')] |
    quote[starts-with(.,'Fallen Cherub, to be weak is miserable')] |
    quote[starts-with(.,'Is the region, this the soil')] |
    quote[starts-with(.,'this the seat')] |
    quote[starts-with(.,'Princes, Potentates')] |
    quote[starts-with(.,'O myriads of immortal Spirits')]"/>
  
  <p:add-attribute attribute-name="who" attribute-value="Beelzebub"
    match="quote[starts-with(.,'O Prince, O Chief of many throned Powers')] |
           quote[starts-with(.,'Leader of those armies bright')] "/>

</p:declare-step>
