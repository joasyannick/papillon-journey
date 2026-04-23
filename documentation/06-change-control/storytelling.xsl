<?xml version="1.0" encoding="utf-8"?>
<!--
  SPDX-FileCopyrightText: 2026 Chrysalide Learning
  SPDX-FileCopyrightText: 2026 Joas Yannick Kinouani
  SPDX-License-Identifier: GPL-3.0-or-later
-->
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:storytelling="http://chrysalide-learning.coop/ns/storytelling"
    xmlns:docbook="http://docbook.org/ns/docbook"
    exclude-result-prefixes="storytelling docbook">

  <xsl:output method="xml" indent="yes" encoding="utf-8"/>

  <xsl:template match="/">
    <xsl:comment>
      <xsl:text>&#10;  SPDX-FileCopyrightText: </xsl:text>
      <xsl:value-of select="year-from-date(current-date())"/>
      <xsl:text> Chrysalide Learning&#10;  SPDX-FileCopyrightText: </xsl:text>
      <xsl:value-of select="year-from-date(current-date())"/>
      <xsl:text> Joas Yannick Kinouani&#10;  SPDX-License-Identifier: GPL-3.0-or-later&#10;</xsl:text>
    </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates select="storytelling:*"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment>
      <xsl:text>&#10;  Generated from </xsl:text>
      <xsl:value-of select="tokenize(document-uri(/), '/')[last()]"/>
      <xsl:text> using storytelling.xsl.&#10;  See the Lifecycle Management Playbook [ββ] for regeneration instructions.&#10;</xsl:text>
    </xsl:comment>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="storytelling:*">
    <xsl:apply-templates select="docbook:article"/>
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

  ## Story 9 — 2026-04-23

  ### Authors

  - Joas Yannick Kinouani

  ### Agents

  - Claude Code: Sonnet 4.6
  - Codex: GPT-5.4

  ### Added

  - Extracts the DocBook article from a storytelling document.
-->
