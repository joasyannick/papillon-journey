<?xml version="1.0" encoding="utf-8"?>
<!--
  SPDX-FileCopyrightText: 2026 Chrysalide Learning
  SPDX-FileCopyrightText: 2026 Joas Yannick Kinouani
  SPDX-License-Identifier: GPL-3.0-or-later
-->
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:c="http://chrysalide-learning.coop/ns/contributions"
    xmlns="http://docbook.org/ns/docbook"
    exclude-result-prefixes="c">

  <!--
    Transforms a contributor profile into an abridged DocBook <personname>
    element, suitable for use in bibliographies.
  -->

  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <xsl:template match="/">
    <xsl:comment>
      <xsl:text>&#10;  SPDX-FileCopyrightText: </xsl:text>
      <xsl:value-of select="year-from-date(current-date())"/>
      <xsl:text> Chrysalide Learning&#10;  SPDX-License-Identifier: GPL-3.0-or-later&#10;</xsl:text>
    </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates select="c:contributor"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment>
      <xsl:text>&#10;  Generated from contributor.xml by author-abridged.xsl.&#10;  Do not edit directly.&#10;</xsl:text>
    </xsl:comment>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="c:contributor">
    <author xml:lang="en-GB" version="5.1">
      <personname>
        <givenname><xsl:value-of select="c:name/c:given"/></givenname>
        <xsl:if test="c:name/c:additional">
          <othername><xsl:value-of select="c:name/c:additional"/></othername>
        </xsl:if>
        <xsl:if test="c:name/c:family">
          <surname><xsl:value-of select="c:name/c:family"/></surname>
        </xsl:if>
      </personname>
    </author>
  </xsl:template>

</xsl:stylesheet>
<!--
  # Changelog

  ## User Story 9 — 2026-04-04

  ### Authors

  - Joas Yannick Kinouani

  ### Added

  - Defined the abridged author transformation.
-->
