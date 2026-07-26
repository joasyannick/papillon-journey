<?xml version="1.0" encoding="utf-8"?>
<!--
  SPDX-FileCopyrightText: 2026 Chrysalide Learning
  SPDX-FileCopyrightText: 2026 Joas Yannick Kinouani
  SPDX-License-Identifier: GPL-3.0-or-later
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
  <ns prefix="contrib" uri="http://chrysalide-learning.coop/ns/contributors"/>

  <pattern>
    <rule context="contrib:given | contrib:additional | contrib:family">
      <assert test="not(contrib:translation) or not(text()[normalize-space()])">
        A name part must not carry both inline text and a translation.
      </assert>
    </rule>
  </pattern>
</schema>
<!--
  # Changelog

  ## Story 1 — 2026-07-16

  ### Authors

  - Joas Yannick Kinouani

  ### Agents

  - Claude Code: Sonnet 5
  - Codex: GPT-5.6 Sol

  ### Added

  - Introduced the contributor Schematron rules.

  ### Future work

  - Generalise and polish contributor validation rules.
-->
