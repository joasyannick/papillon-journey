<?xml version="1.0" encoding="utf-8"?>
<!--
  SPDX-FileCopyrightText: 2026 Chrysalide Learning
  SPDX-FileCopyrightText: 2026 Joas Yannick Kinouani
  SPDX-License-Identifier: GPL-3.0-or-later
-->
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:contrib="http://chrysalide-learning.coop/ns/contributors"
    xmlns="http://docbook.org/ns/docbook"
    exclude-result-prefixes="contrib">

  <!--
    Transforms a contributor profile into a DocBook <author> or <editor> element.
    Pass role=editor to produce an <editor> element instead of the default <author>.
    Pass detail=name for a personname-only element suitable for bibliographies.
    Defaults to full output including affiliation and GitHub URI.
  -->

  <xsl:param name="role" select="'author'"/>
  <xsl:param name="detail" select="'full'"/>

  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <xsl:template match="/">
    <!-- REUSE-IgnoreStart -->
    <xsl:comment>
      <xsl:text>&#10;  SPDX-FileCopyrightText: </xsl:text>
      <xsl:value-of select="year-from-date(current-date())"/>
      <xsl:text> Chrysalide Learning&#10;  SPDX-License-Identifier: GPL-3.0-or-later&#10;</xsl:text>
    </xsl:comment>
    <!-- REUSE-IgnoreEnd -->
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates select="contrib:contributor"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment>
      <xsl:text>&#10;  Generated from ./contributor.xml using ../contributor.xsl.&#10;  Do not edit directly.&#10;  See the _Lifecycle management playbook_ [ββ] for regeneration instructions.&#10;</xsl:text>
    </xsl:comment>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="contrib:contributor">
    <xsl:element name="{$role}" namespace="http://docbook.org/ns/docbook">
      <xsl:attribute name="xml:lang">en-GB</xsl:attribute>
      <xsl:attribute name="version">5.1</xsl:attribute>
      <personname>
        <givenname><xsl:value-of select="contrib:name/contrib:given"/></givenname>
        <xsl:if test="contrib:name/contrib:additional">
          <othername><xsl:value-of select="contrib:name/contrib:additional"/></othername>
        </xsl:if>
        <xsl:if test="contrib:name/contrib:family">
          <surname><xsl:value-of select="contrib:name/contrib:family"/></surname>
        </xsl:if>
      </personname>
      <xsl:if test="$detail = 'full'">
        <xsl:for-each select="contrib:affiliation">
          <affiliation>
            <xsl:for-each select="contrib:position">
              <jobtitle><xsl:value-of select="."/></jobtitle>
            </xsl:for-each>
            <orgname><xsl:value-of select="contrib:name"/></orgname>
          </affiliation>
        </xsl:for-each>
      </xsl:if>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
<!--
  # Changelog

  ## Story 1 — 2026-07-08

  ### Authors

  - Joas Yannick Kinouani

  ### Agents

  - Claude Code: Sonnet 5
  - Codex: GPT-5.5

  ### Added

  - Introduced the author transformation.
-->
