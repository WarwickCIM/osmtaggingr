# OSM Tagging Proposals Data

A data frame with 724 rows and 30 columns, containing all Approved,
Rejected and Proposed tagging proposals from the [OSM
Wiki](https://wiki.openstreetmap.org), as well as their associated
metadata. This dataset has been created by the function
[`get_tagging_proposals()`](https://warwickcim.github.io/osmtaggingr/reference/get_tagging_proposals.md)
ran from the script `data-raw/tagging_proposals.R`.

## Usage

``` r
proposals
```

## Format

columns:

- status:

  a factor describing the proposal status: Approved, Rejected or
  Proposed.

- title:

  a string with the wiki page containing the proposal

- sortkeyprefix:

  a string

- timestamp:

  a date and time. Not sure what which refers to. DELETE?

- pagelanguage:

  a factor with the page's language. NOT WORKING, ALWAYS ENGLISH AND IT
  IS NOT TRUE. FIND ALTERNATIVE WAYS OF RETRIEVING THIS

- touched:

  a timestamp when the page was last touched

- length:

  (integer) page's length, in bytes.

- fullurl:

  (string) URL pointing to the proposal's page.

- editurl:

  (string) the URL to edit the page.

- pageid:

  (int) the page's ID.

- page_creator:

  (factor) the username who created the page.

- date_of_page_creation:

  (date) the date and time in which the page was created.

- latest_editor:

  (factor) the username who last edited the page.

- date_of_latest_edit:

  (date) the date and time in which the page was last updated.

- total_number_of_edits:

  (integer) number of total times that the page has been edited.

- total_number_of_disctinct_authors:

  (integer) number of distinct users who have edited the page.

- proposal_status:

  (factor) status of a proposal.

- proposed_by:

  a string containing the name of the user(s) making the proposal.

- tagging:

  a string describing the proposed tagging scheme

- applies_to_node:

  (Boolean) whether this tag applies to nodes or not.

- applies_to_way:

  (Boolean) whether this tag applies to ways or not.

- applies_to_area:

  (Boolean) whether this tag applies to areas or not.

- applies_to_relation:

  (Boolean) whether this tag applies to relations or not.

- definition:

  a string containing a a short definition of what the tagging proposal
  aims to describe.

- rendered_as:

  a string describing how the tagg is/should be rendered in the map (if
  any).

- draft_started:

  date in which the proposal draft started.

- rfc_start:

  date in which Request For Comments (RFC) started.

- vote_start:

  date in which the voting process started.

- vote_end:

  date in which the voting process ended.

## Source

<https://wiki.openstreetmap.org/wiki/Proposal_process>

## Details

This documentation is not yet complete: lacks all the final fields from
the dataset.
