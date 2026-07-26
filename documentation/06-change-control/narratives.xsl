<?xml version="1.0" encoding="utf-8"?>
<!--
  SPDX-FileCopyrightText: 2026 Chrysalide Learning
  SPDX-FileCopyrightText: 2026 Joas Yannick Kinouani
  SPDX-License-Identifier: GPL-3.0-or-later
-->
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:narratives="http://chrysalide-learning.coop/ns/narratives"
    xmlns:docbook="http://docbook.org/ns/docbook"
    exclude-result-prefixes="narratives docbook">

  <xsl:output method="xml" indent="yes" encoding="utf-8"/>

  <xsl:template match="/">
    <!-- REUSE-IgnoreStart -->
    <xsl:comment>
      <xsl:text>&#10;  SPDX-FileCopyrightText: </xsl:text>
      <xsl:value-of select="year-from-date(current-date())"/>
      <xsl:text> Chrysalide Learning&#10;  SPDX-FileCopyrightText: </xsl:text>
      <xsl:value-of select="year-from-date(current-date())"/>
      <xsl:text> Joas Yannick Kinouani&#10;  SPDX-License-Identifier: GPL-3.0-or-later&#10;</xsl:text>
    </xsl:comment>
    <!-- REUSE-IgnoreEnd -->
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates select="narratives:*"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment>
      <xsl:text>&#10;  Generated from </xsl:text>
      <xsl:value-of select="tokenize(base-uri(/*), '/')[last()]"/>
      <xsl:text> using narratives.xsl.&#10;  Do not edit directly.&#10;  See the _Lifecycle management playbook_ [ββ] for regeneration instructions.&#10;</xsl:text>
    </xsl:comment>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="narratives:*">
    <xsl:apply-templates select="docbook:article">
      <xsl:with-param name="narrative" select="." tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="docbook:article">
    <xsl:param name="narrative" tunnel="yes"/>
    <xsl:element name="article" namespace="http://docbook.org/ns/docbook">
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="docbook:info"/>
      <xsl:call-template name="generate-introduction">
        <xsl:with-param name="narrative" select="$narrative"/>
      </xsl:call-template>
      <xsl:apply-templates select="docbook:*[not(self::docbook:info)]"/>
      <xsl:call-template name="generate-activity-notes">
        <xsl:with-param name="narrative" select="$narrative"/>
      </xsl:call-template>
    </xsl:element>
  </xsl:template>

  <xsl:template name="generate-introduction">
    <xsl:param name="narrative"/>
    <xsl:element name="section" namespace="http://docbook.org/ns/docbook">
      <xsl:element name="title" namespace="http://docbook.org/ns/docbook">Introduction</xsl:element>
      <xsl:element name="simpara" namespace="http://docbook.org/ns/docbook">
        <xsl:text>This document records </xsl:text>
        <xsl:value-of select="concat(upper-case(substring(local-name($narrative), 1, 1)), substring(local-name($narrative), 2))"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="$narrative/@id"/>
        <xsl:text> within the controlled change system of </xsl:text>
        <xsl:element name="productname" namespace="http://docbook.org/ns/docbook">Papillon Journey</xsl:element>
        <xsl:text>.</xsl:text>
      </xsl:element>
      <xsl:element name="simpara" namespace="http://docbook.org/ns/docbook">
        <xsl:text>The </xsl:text>
        <xsl:value-of select="local-name($narrative)"/>
        <xsl:text> defines the motivation, narrative context, ownership, and lifecycle placement of this work item, and provides traceability within the project's documentation structure.</xsl:text>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template name="generate-activity-notes">
    <xsl:param name="narrative"/>
    <xsl:element name="section" namespace="http://docbook.org/ns/docbook">
      <xsl:element name="title" namespace="http://docbook.org/ns/docbook">Activity notes</xsl:element>
      <xsl:element name="itemizedlist" namespace="http://docbook.org/ns/docbook">
        <xsl:for-each select="('01-elicitation', '02-evaluation', '03-specification',
                               '04-development', '05-verification', '06-validation',
                               '07-integration', '08-retrospective')">
          <xsl:variable name="dir"  select="."/>
          <xsl:variable name="name" select="substring-after(., '-')"/>
          <xsl:variable name="uri"  select="resolve-uri(concat($dir, '/', $name, '.xml'),
                                                        base-uri($narrative))"/>
          <xsl:variable name="applicable"
            select="exists($narrative/narratives:activities/narratives:*[local-name() = $name])"/>
          <xsl:element name="listitem" namespace="http://docbook.org/ns/docbook">
            <xsl:element name="simpara" namespace="http://docbook.org/ns/docbook">
              <xsl:value-of select="concat(upper-case(substring($name, 1, 1)), substring($name, 2))"/>
              <xsl:text>: </xsl:text>
              <xsl:choose>
                <xsl:when test="not($applicable)">N/A</xsl:when>
                <xsl:when test="doc-available($uri)">
                  <xsl:text>[</xsl:text>
                  <xsl:value-of select="doc($uri)/*/docbook:article/docbook:info/docbook:biblioid"/>
                  <xsl:text>]</xsl:text>
                </xsl:when>
                <xsl:otherwise>TBD</xsl:otherwise>
              </xsl:choose>
            </xsl:element>
          </xsl:element>
        </xsl:for-each>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="docbook:*">
    <xsl:element name="{local-name()}" namespace="http://docbook.org/ns/docbook">
      <xsl:apply-templates select="@* | node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
<!--
  # Changelog

  ## Story 1 — 2026-07-16

  ### Authors

  - Joas Yannick Kinouani

  ### Agents

  - Claude Code: Sonnet 5
  - Codex: GPT-5.6 Sol

  ### Added

  - Extracts the DocBook article from a narratives document.

  ### Future work

  - Generalise and polish narrative generation.
-->
