# Papillon Journey

Online JRPG teaching systems and software engineering fundamentals through
immersive gameplay. Chrysal Studio is its integrated engineering environment,
built to sustain it.

## Scope

Early documentation phase (v0.1.0). The current focus is vision, value
propositions, and lifecycle management.

## Branching

- **Main branch**: `canon`
- **Feature branches**: `<team>/<narrative-type>/<github-id>-<branch-label>`

## Documentation

- **Format**: DocBook 5.1
- **Default paragraph element**: `<simpara>`
- **Indentation**: 2 spaces
- **File ending**: all files must end with a newline
- **Shared fragments**: `documentation/shared/`
- **Templates**: `documentation/templates/`
- **Toolchain**: `documentation/tools/`
- **Vision document**: `documentation/01-vision/`
- **Change control**: `documentation/05-change-control/`
- **Contributors**: `documentation/07-contributions/01-people/`

Extract reusable content into `shared/` and include it via XInclude:
```xml
<xi:include href="../shared/fragment.xml"/>
```

A document's glossary and bibliography must contain only entries used in that
document:
- **Glossary**: include entries referenced in the document body, plus all
  entries in the same connected component of the `<glossseealso>` graph
- **Bibliography**: include only entries cited in the document body

`<glossseealso>` links are bidirectional: if entry A links to entry B, B must
also link back to A.

Project-authored commentable files without a built-in changelog mechanism (such
as `<revhistory>`) carry a footer changelog in Keep a Changelog format, using
User Story numbers instead of release versions. The union of authors listed
across all changelog entries must equal the SPDX copyright holders of the file.
Use `<!-- -->` for XML files, `/* */` for CSS files, and `#` for files using
line comments (TOML, `.gitignore`):
```xml
<!--
  # Changelog

  ## User Story N — YYYY-MM-DD

  ### Authors

  - Author Name

  ### Added

  - ...
-->
```

## Writing conventions

- Use British typography and American phrasing
- First-level quotations use single quotes; second-level quotations use double
  quotes
- Use em dashes (—) for parenthetical content, not en dashes (–)
- Use the Oxford comma in lists of three or more items

## Licensing

Keep the project REUSE-compliant:
- Store licence texts in `LICENSES/` using SPDX filenames
- For project-authored files that can carry headers:
  - Set SPDX `License-Identifier` to `GPL-3.0-or-later`
  - Use SPDX `FileCopyrightText` to credit Chrysalide Learning and the author
- Preserve upstream copyright notices in third-party files
- Use `REUSE.toml` for files that cannot carry headers, such as binaries or
  Markdown, or for upstream notices that are not REUSE-compliant

## Commit messages

- Title line: max 72 characters — new line included
- Other lines: max 80 characters — new line included
- Exactly one `--` line (state before) and one `=>` line (state after)
- At most one `*` line (optional additional info)

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

## Current work

User Story 9: Write Vision (branch `product/stories/9-write-vision`)

Stakeholder groups:
1. Video game players
2. Software engineering learners
3. Software engineering educators
4. Software engineering practitioners
5. Software engineering researchers

Outstanding TODOs:
- Complete educators' value propositions
- Complete practitioners' value propositions
- Complete researchers' value propositions
- Lifecycle management documentation
- Success metrics definition
