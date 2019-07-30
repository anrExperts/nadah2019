<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  xpath-default-namespace="xpr" xmlns="http://www.gexf.net/1.2draft" version="2.0">
  <xsl:output encoding="UTF-8" indent="yes"/>
  <xsl:variable name="ids"
    select="distinct-values(/xpr/expertise/sourceDesc/description/entry[key = 'Expert(s)'][1]/value/name/@ref[string()])" />
  <xsl:variable name="experts" select="document('../data/xprExperts.xml')//person[@xml:id = $ids]" />
  <xsl:template match="/">
    <gexf xmlns:xsi="http://www.w3.org/2001/XMLSchema−instance" version="1.2">
      <meta lastmodifieddate="2009-03-20">
        <creator>ANR Experts</creator>
        <description>1726 network</description>
      </meta>
      <graph defaultedgetype="undirected">
        <nodes>
          <xsl:for-each select="$experts">
            <node id="{./@xml:id}" label="{concat(./persName[1]/surname, ', ', ./persName[1]/forename)}">
            </node>
          </xsl:for-each>
        </nodes>
        <edges>
          <xsl:apply-templates select="//entry[key='Expert(s)'][1][count(value/name[@ref[string()]]) = 2]"/>
        </edges>
      </graph>
    </gexf>
  </xsl:template>
  
  <xsl:template match="entry">
    <xsl:variable name="num">
      <xsl:number level="any" count="//entry[key='Expert(s)'][1][count(value/name[@ref[string()]]) = 2]" format="0000"/>
    </xsl:variable>
    <edge id="{concat('edge', $num)}" source="{value/name[1]/@ref}" target="{value/name[2]/@ref}"/>
  </xsl:template>
  
</xsl:stylesheet>
