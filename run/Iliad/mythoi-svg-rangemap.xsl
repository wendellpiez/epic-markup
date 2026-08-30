<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:ml="http://wendellpiez.com/ns/xMNML"
  xmlns="http://www.w3.org/2000/svg"
  xpath-default-namespace="http://wendellpiez.com/ns/xMNML"
  exclude-result-prefixes="#all"
  version="3.0">


<!-- Expected input: rangemap spec, with xMNML document as a parameter -->
  
  <xsl:param required="yes" name="bookNo"/>

  <xsl:variable name="sheetSpec" as="element()">
    <SHEET paddingUL="50" paddingLR="30" scale="20" aspect="0.62"
      font-family="'Cambria'" fill="lemonchiffon" fill-opacity="0.2"/>
  </xsl:variable>

  <!--<xsl:variable name="max-drop" select="$sheetSpec//*/(sum(ancestor-or-self::*/@drop) + ancestor-or-self::*[@w][1]/@w) => max()"/>-->

  <xsl:variable name="scale"   select="($sheetSpec/@scale,1)[1]"/>
  <xsl:variable name="scaling" select="1 div $scale"/>
  
  <xsl:variable name="fullWidth" select="(string-length(/*/frontier) * $scaling)"/>
  
  <xsl:variable name="pageWidth" select="$fullWidth + ($sheetSpec/@paddingUL + $sheetSpec/@paddingLR)"/>
    
  <xsl:variable name="aspect" select="($sheetSpec/@aspect,1)[1]"/>
  
  <!-- pageHeight accounts for extra drop for multiple layers -->
  <xsl:variable name="pageHeight" select="($fullWidth * $aspect) + ($sheetSpec/@paddingUL + $sheetSpec/@paddingLR)"/>

  
  <xsl:template match="/*" name="build-map" expand-text="true">
    <svg width="{ $pageWidth }" height="{ $pageHeight }">
      <rect width="100%" height="100%" fill="white" fill-opacity="1" stroke="black" stroke-width="1"/>
      <g font-family="Cambria" font-size="8" transform="translate({ $sheetSpec/@paddingUL } { $sheetSpec/@paddingUL })">
        <xsl:apply-templates select=".//range" mode="draw-range">
          <xsl:sort select="@ending - @starting" order="descending"/>
          <xsl:sort select="@starting" order="ascending"/>
        </xsl:apply-templates>
      </g>
      <text x="30" y="30" font-size="14">ILIAD ILLUMINATED - Book { $bookNo }</text>
    </svg>
  </xsl:template>

  <xsl:function name="ml:size">
    <xsl:param name="v" as="xs:double"/>
    <xsl:sequence select="$v * $scaling"/>
  </xsl:function>

  <xsl:template match="ml:range" mode="draw-range" expand-text="true">
    <!-- $drawSpec can be a course or a course//track -->
    <xsl:variable name="here" select="."/>
    <xsl:variable name="offset" as="xs:double" select="@starting"/>
    <xsl:variable name="length" as="xs:double" select="@ending - @starting"/>
    
    <xsl:variable name="x1"    select="ml:size( $offset )"/>
    <xsl:variable name="hSpan" select="ml:size( $length )"/>
    <xsl:variable name="y1"    select="($x1    * $aspect)"/>
    <xsl:variable name="vSpan" select="$hSpan * $aspect"/>
    
    <xsl:variable name="rangeSpec" as="map(*)" select="map {
      'x1': $x1, 'y1': $y1, 'x2': ($x1 + $hSpan), 'y2': ($y1 + $vSpan),
      'width': $hSpan, 'height': $vSpan }"/>
    
    <!--<xsl:variable name="font-size" select="($sheetSpec/@font-size, 12)[1]"/>-->
    
    <xsl:apply-templates select="." mode="draw">
      <xsl:with-param name="placement" select="$rangeSpec" tunnel="true"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template mode="spotlight" match="range">
    <xsl:param name="placement" as="map(*)" tunnel="true"/>
    <xsl:variable name="strokeWeight" select="0.01 * $placement?height"/>
    
    <path fill-rule="evenodd" d="M 0 { $placement?y1 } L { $placement?x1 } { $placement?y1 }
      L { $placement?x1 } 0 L { $placement?x2 } 0 L { $placement?x2 } { $placement?y1 } L { $fullWidth } { $placement?y1 }
      L { $fullWidth } { $placement?y2 } L { $placement?x2 } { $placement?y2 } L { $placement?x2 } { $fullWidth * $aspect }
      L { $placement?x1 }  { $fullWidth * $aspect } L { $placement?x1 } { $placement?y2 }   
      L 0 { $placement?y2 } Z
      "             
      stroke="black" stroke-width="{ $strokeWeight }" fill="forestgreen" fill-opacity="0.1" stroke-opacity="0.2">
      <xsl:apply-templates select="." mode="decorate"/>
    </path>
    <xsl:apply-templates select="." mode="label"/>
  </xsl:template>
  
  
    <!--Catch-all template rule matches anything and draws a box ... -->
  <xsl:template mode="draw" match="*" name="box">
    <xsl:param name="placement" as="map(*)" tunnel="true"/>
    <rect x="{ $placement?x1 }" y="{ $placement?y1 }" width="{ $placement?width }"
      height="{ $placement?height }" stroke="black" stroke-width="0.1" fill="steelblue"
      fill-opacity="0.2">
      <xsl:apply-templates select="." mode="decorate"/>
    </rect>
    <xsl:apply-templates select="." mode="label"/>
  </xsl:template>
  
  <xsl:template mode="draw" match="range[@gi=('div','para','BOOK')]" priority="11" name="lozenge">
    <xsl:param name="placement" as="map(*)" tunnel="true"/>
    <xsl:variable name="strokeWeight" select="0.01 * $placement?height"/>
    <path d="M { $placement?x1 } { $placement?y1 } Q { $placement?x2 } { $placement?y1 } { $placement?x2 } { $placement?y2 } 
      Q { $placement?x1 } { $placement?y2 } { $placement?x1 } { $placement?y1 } Z"
      stroke="black" stroke-width="{ $strokeWeight }" fill="forestgreen" fill-opacity="0.1" stroke-opacity="0.2">
      <xsl:apply-templates select="." mode="decorate"/>
    </path>
    <xsl:apply-templates select="." mode="label"/>
  </xsl:template>
  
  <xsl:template mode="draw" match="range[@gi=('l')]" priority="11" name="spike">
    <xsl:param name="placement" as="map(*)" tunnel="true"/>
    <xsl:variable name="strokeWeight" select="0.01 * $placement?height"/>
    <xsl:variable name="w" select="$placement?height * $aspect"/>
    <xsl:variable name="wa" select="$w * $aspect"/>
    
    <path d="M { $placement?x2 + $w } { $placement?y1 - $wa }
      L { $placement?x2 } { $placement?y2 }
      L { $placement?x1 - $w } { $placement?y2 + $wa }
      L { $placement?x1 } { $placement?y1 } Z"
      stroke="black" stroke-width="{ $strokeWeight }" fill="forestgreen" fill-opacity="0.1" stroke-opacity="0.2">
      <xsl:apply-templates select="." mode="decorate"/>
    </path>
    <xsl:apply-templates select="." mode="label"/>
  </xsl:template>
  
  <xsl:template mode="draw" match="range[@gi=('assembly','force')]" priority="11" name="band">
    <xsl:param name="placement" as="map(*)" tunnel="true"/>
    <xsl:variable name="strokeWeight" select="0.01 * $placement?height"/>
    <xsl:variable name="w" select="$placement?height * $aspect"/>
    <xsl:variable name="wa" select="$w * $aspect"/>
    
    <path d="M { $placement?x1 + $w } { $placement?y1 - $wa }
      L { $placement?x2 + $w } { $placement?y2 - $wa }
      L { $placement?x2 - $w } { $placement?y2 + $wa }
      L { $placement?x1 - $w } { $placement?y1 + $wa } Z"
      stroke="black" stroke-width="{ $strokeWeight }" fill="forestgreen" fill-opacity="0.1" stroke-opacity="0.2">
      <xsl:apply-templates select="." mode="decorate"/>
    </path>
    <xsl:apply-templates select="." mode="label"/>
  </xsl:template>
  
  <xsl:template mode="draw" match="range[not(.)]" priority="11" name="blob">
    <xsl:param name="placement" as="map(*)" tunnel="true"/>
    <xsl:variable name="strokeWeight" select="0.01 * $placement?height"/>
    
    <path d="M { $placement?x1 } { $placement?y1 } Q { $placement?x2 + $placement?width } { $placement?y1 - $placement?height } { $placement?x2 } { $placement?y2 } 
      Q { $placement?x1 - $placement?width } { $placement?y2 + $placement?height } { $placement?x1 } { $placement?y1 } Z"
      stroke="black" stroke-width="{ $strokeWeight }" fill="forestgreen" fill-opacity="0.1" stroke-opacity="0.2">
      <xsl:apply-templates select="." mode="decorate"/>
    </path>
    <xsl:apply-templates select="." mode="label"/>
  </xsl:template>
  
  <xsl:template mode="draw" match="range[@gi=('scene','tale')]" priority="11" name="wedge">
    <xsl:param name="placement" as="map(*)" tunnel="true"/>
    <xsl:variable name="centerX" select="($placement?x1 + $placement?x2) div 2"/>
    <xsl:variable name="centerY" select="($placement?y1 + $placement?y2) div 2"/>
    <xsl:variable name="strokeWeight" select="0.01 * $placement?height"/>
    
    <!--<xsl:apply-templates select="." mode="spotlight"/>-->
    
    <path d="M { $placement?x2 } { $placement?y2 }
      L { $placement?x2 } { $placement?y1 - $placement?height }
      L { $placement?x1 - $placement?width } { $placement?y2 } Z" fill-opacity="0.2"
      stroke-width="{ $strokeWeight }">
      <xsl:apply-templates select="." mode="decorate"/>
    </path>
    <xsl:apply-templates select="." mode="label"/>
  </xsl:template>
  
  
  <xsl:template mode="draw" match="range[@gi=('speech','simile','trope','prayer')]" priority="11" name="wings">
    <xsl:param name="placement" as="map(*)" tunnel="true"/>
    <xsl:variable name="centerX" select="($placement?x1 + $placement?x2) div 2"/>
    <xsl:variable name="centerY" select="($placement?y1 + $placement?y2) div 2"/>
    <xsl:variable name="strokeWeight" select="0.01 * $placement?height"/>

    <!--<xsl:apply-templates select="." mode="spotlight"/>-->
    
    <path d="M { $placement?x1 } { $placement?y1 }
      Q { $centerX } { $placement?y1 } { $placement?x2 } { $placement?y1 - $placement?height }
      L { $placement?x2 } { $placement?y2 }
      L { $placement?x1 - $placement?width } { $placement?y2 }
      Q { $placement?x1 } { $placement?y2 } { $placement?x1 } { $placement?y1 } Z" fill-opacity="0.2"
      stroke-width="{ $strokeWeight }">
      <xsl:apply-templates select="." mode="decorate"/>
    </path>
    <xsl:apply-templates select="." mode="label"/>
  </xsl:template>
  
  <xsl:template match="*" mode="decorate"/>
  
  <xsl:template match="ml:range[@gi=('div','BOOK')]" mode="decorate" expand-text="true">
    <xsl:attribute name="fill">lightsteelblue</xsl:attribute>
    <xsl:attribute name="fill-opacity">0.2</xsl:attribute>
    <xsl:attribute name="stroke">lightsteelblue</xsl:attribute>
    <xsl:attribute name="stroke-opacity">0.8</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="ml:range[@gi='scene']" mode="decorate" expand-text="true">
    <xsl:attribute name="fill">gold</xsl:attribute>
    <xsl:attribute name="stroke">maroon</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="ml:range[@gi='tale']" mode="decorate" expand-text="true">
    <xsl:attribute name="fill">darkorange</xsl:attribute>
    <xsl:attribute name="stroke">firebrick</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="ml:range[@gi='simile']" mode="decorate" expand-text="true">
    <xsl:attribute name="text-anchor">end</xsl:attribute>
    <xsl:attribute name="fill">red</xsl:attribute>
    <xsl:attribute name="stroke">darkred</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="ml:range[@gi='trope']" mode="decorate" expand-text="true">
    <xsl:attribute name="text-anchor">end</xsl:attribute>
    <xsl:attribute name="fill">steelblue</xsl:attribute>
    <xsl:attribute name="stroke">purple</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="ml:range[@gi='speech']" mode="decorate" expand-text="true">
    <xsl:attribute name="fill">steelblue</xsl:attribute>
    <xsl:attribute name="stroke">midnightblue</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="ml:range[@gi='prayer']" mode="decorate" expand-text="true">
    <xsl:attribute name="fill">green</xsl:attribute>
    <xsl:attribute name="stroke">darkgreen</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="ml:range[@gi='assembly']" mode="decorate" expand-text="true">
    <xsl:attribute name="text-anchor">end</xsl:attribute>
    <xsl:attribute name="fill">rosybrown</xsl:attribute>
    <xsl:attribute name="stroke">black</xsl:attribute>
    <xsl:attribute name="stroke-opacity">0.7</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="ml:range[@gi=('tale','para','l')]" mode="label"/>
  
  <xsl:template match="*" mode="label" expand-text="true">
    <xsl:param name="placement" as="map(*)" tunnel="true"/>
    <xsl:variable name="fontSize">
        <xsl:apply-templates select="." mode="label-size"/>
    </xsl:variable>
    <xsl:variable name="strokeWeight" select="0.01 * $placement?height"/>
    <g transform="translate({ $placement?x1 } { $placement?y1 + $fontSize })" font-size="{ $fontSize }">
      <text text-anchor="start" stroke-width="{ $strokeWeight div 2 }">
        <xsl:apply-templates select="." mode="decorate"/>
        <xsl:apply-templates select="." mode="label-text"/>
      </text>
    </g>
    <path d="M { $placement?x1 } { $placement?y1 + $fontSize }
      L { $placement?x1 } { $placement?y1 }"
      stroke-width="{ $strokeWeight }">
      <xsl:apply-templates select="." mode="decorate"/>
      <xsl:attribute name="fill">none</xsl:attribute>
    </path>
  </xsl:template>
  
  
  <xsl:template mode="label-size" expand-text="true" match="*">
    <xsl:param name="placement" as="map(*)" tunnel="true"/>
    <xsl:text>{ 0.2 * $placement?height }</xsl:text>
  </xsl:template>
  
  <!-- Simile labels always 20 despite how big or small -->
  <xsl:template mode="label-size" expand-text="true" match="ml:range[@gi=('simile','trope')]">20</xsl:template>
  
  <xsl:template match="*" mode="label-text" expand-text="true">
    <xsl:text>{ @gi }</xsl:text>
  </xsl:template>
  
  <xsl:template match="range[@gi=('simile','trope')]" mode="label-text" expand-text="true">
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template match="range[@gi=('div','BOOK')]" mode="label-text" expand-text="true">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="fill">none</xsl:attribute>
    <xsl:text>Book { child::annotation[@gi='n'] }</xsl:text>
  </xsl:template>
  
  <xsl:template match="range[@gi='assembly']" mode="label-text" expand-text="true">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:text>{ (child::annotation[@gi=('who','name','title')],'Assembly') => head() }</xsl:text>
  </xsl:template>
  
  <xsl:template match="range[@gi='force'] | range[@gi='tale']" mode="label-text" expand-text="true"/>
    
  <xsl:template match="range[@gi='speech']" mode="label-text" expand-text="true">
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:text>{ child::annotation[@gi='by'] }: to { child::annotation[@gi='to'] }</xsl:text>
  </xsl:template>
  
  <xsl:template match="range[@gi='scene']" mode="label-text" expand-text="true">
    <xsl:text>{ child::annotation[@gi='set'] }</xsl:text>
  </xsl:template>
  
</xsl:stylesheet>