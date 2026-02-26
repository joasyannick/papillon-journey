# Papillon Journey

Online JRPG teaching systems and software engineering fundamentals through immersive gameplay.

## Project Status

Early documentation phase (v0.1.0). Focus is on vision, value propositions, and lifecycle management. Game development has not yet started.

## Branch Conventions

- **Main branch**: `canon`
- **Feature branches**: `<team>/<narrative-type>/<github-id>-<branch-label>`

## Documentation

- **Format**: DocBook 5.1
- **Shared fragments**: `documentation/shared/`
- **Templates**: `documentation/templates/`
- **Doc toolchain**: `documentation/tools/`
- **Vision document**: `documentation/01-vision/`
- **Change control**: `documentation/05-change-control/` (sorted by narrative types)
- **Contributors**: `documentation/07-contributions/01-people/`

### XInclude Usage

Reusable content should be extracted to `shared/` and included via XInclude:
```xml
<xi:include href="../shared/fragment.xml"/>
```

## Commit Message Format

- Title line: max 72 characters
- Other lines: max 80 characters
- Exactly one `--` (state before) and one `=>` (state after)
- At most one `*` (additional info) — optional

```
<title>
-- <state-before>.
=> <state-after>.
* <additional-information>.
[<team>: <narrative-type> <github-id>]
```

Example:
```
Factorise reusable snippets from the vision document
-- Other documents will have the same author, publisher, or introduction.
=> Extracted shareable fragments for reuse via XInclude.
* Enhanced phrasing along the way.
[Product: User Story 9]
```

## Conventions

- **Language**: British spelling (e.g., "colour", "centre", "artefacts") but American phrasing
  - Use em dashes (—) for parenthetical content, not en dashes
- **License**: GNU GPL v3
  - Files should follow REUSE best practices
- **REUSE**:
  - License texts live in `LICENSES/` using SPDX filenames (for example, `GPL-3.0-or-later.txt`)
  - Project-authored XML files should use inline SPDX headers:
    - `SPDX-FileCopyrightText: <year> Chrysalide Learning`
    - `SPDX-FileCopyrightText: <year> <author>`
    - `SPDX-License-Identifier: GPL-3.0-or-later`
  - For third-party files, preserve upstream notices and attribution
  - Do not replace third-party copyright lines with project ownership
  - If third-party files are uncommentable (for example, binaries), annotate with REUSE-compatible metadata files
- Indent using 2 spaces
- **DocBook**: default paragraph element is `<simpara>`

## Current Work

User Story 9: Write Vision (branch `product/stories/9-write-vision`)

Stakeholder groups:
1. Video game players (VPαʹ1–5)
2. Software engineering learners (VPαʹ6–9)
3. Software engineering educators (VPαʹ10–11)
4. Software engineering practitioners (VPαʹ12–13)
5. Software engineering researchers (VPαʹ14–15)

Outstanding TODOs:
- Complete educators value propositions (VPαʹ10–11)
- Complete practitioners value propositions (VPαʹ12–13)
- Complete researchers value propositions (VPαʹ14–15)
- Success metrics definition
- Lifecycle management documentation
