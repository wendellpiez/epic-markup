<?xml version="1.0" encoding="UTF-8"?>
<p:library  version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:EPIC="https://github.com/wendellpiez/EpicMarkup/ns"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  exclude-inline-prefixes="#all">

  <!-- emulates p:store, indented
       writing results relative to .. (run directory) -->
  <p:declare-step type="EPIC:store">
    <p:input port="source"/>
    <p:output port="result"/>

    <p:option name="href" required="true"/>
    <p:option name="hint"/>

    <p:store serialization="map { 'indent': true() }" href="../{ $href }"
      message="Storing { $hint } { $href }"/>
  </p:declare-step>

  <!-- Modify received Perseus TEI Header for project
       (make further edits in further steps) -->
  <p:declare-step type="EPIC:teiHeader_update">
    <p:input port="source"/>
    <p:output port="result"/>
    
    <p:delete match="fileDesc/extent"/>
    <p:replace match="fileDesc/titleStmt/title">
      <p:with-input port="replacement">
        <p:inline>
          <title>Liminal ILIAD</title>
        </p:inline>
      </p:with-input>
    </p:replace>
    <p:replace match="fileDesc/publicationStmt">
      <p:with-input port="replacement">
        <p:inline>
          <publicationStmt>
            <publisher>Wendell Piez, <ref target="https://github.com/wendellpiez/EpicMarkup">Epic Markup Project</ref></publisher>
            <availability><p>Please accession, use, copy and modify this enhanced derivative work,
                while acknowledging your sources.</p>
              <p>The encoded original from which this version is derived is made available under a
                <ref target="https://github.com/PerseusDL/canonical-greekLit/tree/master#">CC-BY-SA-4.0</ref> license.
                In conformance with its terms, these derived versions are offered back.</p>
              <p>Herewith must be recognized the Perseus Project, its sponsors, organizers, encoders
                and technical contributors, and the creators of its sources for an electronic version
                of this public domain text. Most transmitters and scribes of Homer have gone unnamed:
                <q>the busy and hapless alike go to death</q> (9.320). We do it because we can,
                and we can, because those before us have done so.</p>
              <licence target="https://creativecommons.org/licenses/by-sa/4.0/deed.en">Creative 
                Commons Attribution-ShareAlike 4.0 International License</licence>
            </availability>
          </publicationStmt>
        </p:inline>
      </p:with-input>
    </p:replace>
    <p:replace match="fileDesc/sourceDesc/biblStruct">
      <p:with-input port="replacement">
        <bibl>Monro and Allen (eds.), <principal>Gregory Crane</principal> et al. <distributor>Perseus
            Project</distributor>. <title rend="italic">Ἰλιάς</title> Available at: <ref
              target="https://github.com/PerseusDL/canonical-greekLit/blob/master/data/tlg0012/tlg001/tlg0012.tlg001.perseus-grc2.xml"
              >https://github.com/PerseusDL/canonical-greekLit/blob/master/data/tlg0012/tlg001/tlg0012.tlg001.perseus-grc2.xml</ref>
          (Accessed: 9 May 2026).</bibl>
      </p:with-input>
    </p:replace>
    <p:delete match="encodingDesc/refsDecl"/>
    <p:insert match="encodingDesc" position="first-child">
      <p:with-input port="insertion">
        <projectDesc>
          <p>For Epic Markup, a Laminator application. In this version, no modifications of source data are made apart from whitespace normalization,
          while tagging has been rewritten from XML into LMNL ("sawtooth") notation, for LMNL-aware operations.</p>
        </projectDesc>
      </p:with-input>
    </p:insert>
    <p:delete match="fileDesc/titleStmt/*[exists(preceding-sibling::author)]"/>
    <p:insert match="fileDesc/titleStmt/respStmt/author" position="after">
      <p:with-input port="insertion">
        <respStmt>
          <resp>Transcoded into LMNL syntax, with enhancements</resp>
          <name>Wendell Piez</name>
        </respStmt>
      </p:with-input>
    </p:insert>
    <p:insert match="teiHeader/revisionDesc" position="first-child">
      <p:with-input port="insertion">
        <change who="Wendell Piez" when="{ current-date() => format-date('[Y]-[M01]-[D01]')}"
          >Transcoded into LMNL syntax</change>
      </p:with-input>
    </p:insert>
    <p:string-replace match="fileDesc//text()" replace="string(.) => replace('\s+',' ')"/>
  </p:declare-step>

</p:library>