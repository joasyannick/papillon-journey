<?xml version="1.0" encoding="utf-8"?>
<!--
  SPDX-FileCopyrightText: 2026 Chrysalide Learning
  SPDX-FileCopyrightText: 2026 Joas Yannick Kinouani
  SPDX-License-Identifier: GPL-3.0-or-later
-->
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:contrib="http://chrysalide-learning.coop/ns/contributions"
    xmlns="http://docbook.org/ns/docbook"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="contrib xlink">

  <!--
    Transforms a contributor profile into a DocBook <author> element.
    Pass detail=name for a personname-only element suitable for bibliographies.
    Defaults to full output including affiliation and GitHub URI.
  -->

  <xsl:param name="detail" select="'full'"/>

  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <xsl:template match="/">
    <xsl:comment>
      <xsl:text>&#10;  SPDX-FileCopyrightText: </xsl:text>
      <xsl:value-of select="year-from-date(current-date())"/>
      <xsl:text> Chrysalide Learning&#10;  SPDX-License-Identifier: GPL-3.0-or-later&#10;</xsl:text>
    </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates select="contrib:contributor"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment>
      <xsl:text>&#10;  Generated from ./contributor.xml using ../author.xsl.&#10;  See the _Lifecycle management playbook_ [ββ] for regeneration instructions.&#10;</xsl:text>
    </xsl:comment>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="contrib:contributor">
    <author xml:lang="en-GB" version="5.1">
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
        <uri role="github" xlink:href="{concat('https://github.com/', contrib:account[@platform='github'])}"/>
        <xsl:for-each select="contrib:organisations/contrib:organisation">
          <affiliation>
            <xsl:for-each select="contrib:position">
              <jobtitle><xsl:value-of select="."/></jobtitle>
            </xsl:for-each>
            <orgname><xsl:value-of select="contrib:name"/></orgname>
          </affiliation>
        </xsl:for-each>
      </xsl:if>
    </author>
  </xsl:template>

</xsl:stylesheet>
<!--
  # Changelog

  ## Story 9 — 2026-05-14

  ### Authors

  - Joas Yannick Kinouani

  ### Agents

  - Claude Code: Sonnet 4.6
  - Codex: GPT-5.5

  ### Added

  - Introduced the author transformation.
-->
