# Field report: two days of agent board work under review

Written 2026-11-21. First-hand evidence, unlike the rest of this topic. Over
2026-11-19 to 21 an agent (Claude, driving KiCad 10 through `kicad-cli` and
boardwright 0.10 and 0.11) brought five BREAD slice templates to revision r4,
and a designer reviewed every change on rendered images. The boards are public:
feastorg/Slice_TEMP_NANO_S2L-r2, Slice_TEMP_NUCL_S4L-r1 (PR #3),
Slice_TEMP_NUCL_L4L-r1 (PR #4), Slice_TEMP_PICO_S2L-r1 (PR #3) and
Slice_TEMP_PICO_L4L-r1 (PR #4), plus fixes on seven r2-family boards. Commits
cited below are on those repos. The working log behind this file is not
published; this is its distillation, with machine-specific detail removed.

It is one project, one reviewer and a handful of boards. No board from it has
been measured. Read it as cases, not rates.

## Headline: the method mattered more than the model

Every board that went to review had passed KiCad's DRC with 0 errors, 0
unconnected items and 0 schematic-parity issues, and ERC with no new errors.
The reviewer still found layout problems on every one. The same agent then
produced the versions the reviewer accepted. What changed between the two was
the order the agent worked in and what it read before acting, not what it
could do.

The clearest case is technique T1 below, on the Nucleo S4L template:

| version | how it was made | F.Cu segments, ESTOP / INT / SYNC | DRC | route lint | reviewer |
| --- | --- | --- | --- | --- | --- |
| edd960f | series parts placed first in a tidy column, then routed to | 5 / 5 / 4 | 0 errors, 38 warnings | 0 | "messy and low quality" |
| 3d9827f | each net routed bare first, the part then placed on its route | 2 / 2 / 2 | 0 errors, 38 warnings | 0 | "MUCH better" |

Segments counted per net on F.Cu from `git show <commit>:hardware/BREAD_Slice.kicad_pcb`.
Neither DRC nor the agent's route lint could tell the versions apart.

## The pattern: read the structure before acting

The techniques that worked share one move: read the structure of the problem
before placing or routing. The failures share the opposite one: act on the
nearest local thing.

| what was read first | what it gave | technique |
| --- | --- | --- |
| the route each net takes with no part on it | 5/5/4 segments to 2/2/2 | T1 |
| the pin order at both ends of a group | parallel runs, no crossings, no vias | T2 |
| why a route is long: a net enclosing its destination | an LED route from 93 mm to 55 mm with one via pair | T3 |
| the pour's actual fill pieces near a pad | the first via, in the obvious gap, changed nothing; one inside the island cleared the error | T5 |
| the pours on every layer under both ends | a redundant ground route deleted | T6 |
| the history of an interface before changing it | a "fix" that would have moved an interrupt off its interrupt pin was not made | below |

The agent's own account of its first-round failures names the cause: it
optimised for what it could measure (the smallest diff, an unchanged DRC
count, an unchanged silk-warning count) rather than for the layout a designer
would draw. Its first failures, each marked by the reviewer:

- **New parts bolted onto old copper.** Solder jumpers replacing a DIP switch
  were joined to the switch's old pad points, keeping its detour and leaving a
  kink at every join, where the reviewer drew a straight 45° run beside it.
- **Router output taken as finished.** Freerouting left stair-stepped pin
  entries, sideways jogs in straight runs, 90° corners, and tracks entering
  connector pads at the corner or passing between another net's pads.
- **Placement and rotation chosen by coordinate,** not by which pad faces which
  net: a resistor rotated so both its nets looped round it.
- **Text judged by a count.** Silk warnings rose from 7 to 22 on one board and
  shipped as a note; a design note was printed over three parts.
- **A change applied to some boards and not others** in a fleet update.

## Techniques

Each technique keeps its conditions. Flattened into a rule ("always route
first"), T1 would get the Nano template wrong, where a column was right.

### T1. Route first, then put series parts in line

- **Problem.** Series parts (resistors, solder jumpers, ferrites) are placed
  first in a neat column, then routed to; every signal gets a dog-leg out to the
  column and back.
- **Move.** Draw each signal as the route it would take with no part: a
  straight run, or the fewest 45° segments. Put the part on that route at the
  route's angle and split the track at its pads. Where parallel runs are too
  close for parts side by side, stagger the parts along their runs. On a run
  that bends, put the part on a straight stretch.
- **Applies to** a two-pin part in series on a signal with a natural path:
  inline passives, solder jumpers, series termination, 0 Ω links.
- **Not when** the parts must be reachable or read as a group (a jumper bank set
  together), a shunt part hangs off a net rather than sitting in it, or the run
  has no straight stretch for the part plus about 1 mm of pad entry each side.
- **The contrast.** On the Nano template a column in J1's pin order worked,
  because all five signals left it toward one header, in the column's order. A
  column works when its outputs fan out in its order toward one destination.
- **Evidence.** The table above. In 3d9827f three parts sit at 45°, staggered
  3.5 to 3.75 mm along their runs, because side by side two courtyards overlapped
  and boardwright refused the move.

### T2. A column in shared pin order needs no vias

When the pin order at both ends of a group matches, place the parts in that
order and the routes run parallel with no crossings. The condition is the
shared order, not the column (T1's contrast). Evidence: the Nano r2 template's
jumper column.

### T3. Cross an enclosing net with a via pair, not a detour

A route far longer than its straight-line distance usually avoids a net that
encloses its destination. Cross that net once with a via pair. Evidence: the
Nano template's LED route went round the board edge, 0.75 mm from it, because
the +5V loop encloses the Nano; one via pair under +5V cut it from 93 mm to
55 mm.

### T4. End every track on the pad centre

Take the pad centre from the board and end the segment on it; for a 45° run
into a pad, choose the line through the centre and work back. Tracks on the
Nucleo S4L stopped 0.04 to 0.07 mm short (fixed in af65e07). KiCad called them
connected; boardwright before 0.11.0 drew them as open (heibench/boardwright#134),
and a reviewer read them as open nets.

### T5. A pour fenced off by your own routes is an island: find it, then stitch it

Two routes and a header column can fence off a wedge of pour with no other way
to its net; a pad whose thermal spokes land in it is starved (KiCad
`starved_thermal`). List the fill pieces near the pad to find the island, then
put one via of the pour's net inside it. Evidence: Pico L4L pin 28 (GND). The
first via went in the strip on the other side of the pad and changed nothing;
the fill list showed the island west of the pad, and a via there cleared the
error (f4e1a07). When a fix does not move the DRC number, the model of the
problem is wrong: read what the tool sees before a second attempt.

### T6. Where every layer is poured, a ground "route" may be redundant

A track joining a through-hole ground pin to the pour, starting in open pour,
adds nothing and crowds the signals beside it. Check the pours on every layer
under both ends; if the pin is through-hole and every layer is poured there,
delete the track. Evidence: Pico L4L, the GND route into pin 23 (a47d051).

### T7. Decoupler on the pin's own rail, nearest the pin, ground by a via

Beside the supply pin it serves, on the shortest straight stub, its ground pad
straight to a via into the plane. Evidence: Nucleo S4L C7 at D1 (66dcfff): a
2.4 mm stub to D1's supply pad and a ground via 1.4 mm from its other pad.

### T8. Give parallel runs the same exit, so their spacing stays even

When parallel 45° runs reach pads that are not on a true 45° line from their
source, some need a short exit stub to land on the pad centre and others do
not, and the spacing goes uneven: 1.3 mm instead of 1.8 mm on the Nucleo L4L.
Give every run in the group the same exit, and move a via along its own run if
it needs to. Evidence: Nucleo L4L PR #4, ESTOP, INT and SYNC.

### T9. A shunt part can straddle two parallel rails

A decoupler can sit across a supply rail and a ground rail running side by
side, one pad on each, both rails passing straight through its pads. If the
rail spacing does not match the pad pitch, nudge the rail vias rather than add
jogs. Evidence: Nucleo L4L C7, 1.725 mm pad pitch across +5VD and GNDD; the
vias moved 0.015 and 0.13 mm. A first try moved the ground rail instead and put
it 0.11 mm from a neighbouring pad, a DRC clearance error.

## Working-practice lessons

These are about how the agent ran the work, not the layout. Several repeated
after being written down; the ones that were caught were caught by a guard in a
tool, not by the written rule.

- **An action chained on a write whose result was not seen.** A refused file
  write let an older spec run, twice. Both times it was harmless and was caught
  from the output.
- **A refusal not read.** Tracks were deleted by text edit, the apply that
  depended on them refused, and the board was saved twice and plotted without
  the refusal being read: 2 unconnected items, caught by DRC before any commit.
  An apply's exit status should gate everything after it.
- **A commit SHA typed from memory** for a merge guard. The guard refused it and
  nothing merged.
- **A local gate that differed from CI's by one flag.** A new via sat inside
  another net's pour. Every local DRC ran with `--refill-zones`, which checks a
  fresh fill, and passed; CI checks the fill as committed and failed on three
  heads before anyone looked. Fixed by saving the refill (9e83a06). Run the
  gate CI runs, and read CI after every push.
- **DRC severity reported from memory.** A pull-request description said 0
  errors where the project rates `starved_thermal` as an error and DRC reported
  one. Count severity from the report, per run.
- **A re-save that rewrote the file.** A 27-line rename shipped as 2,255
  changed lines because the DRC run's `--save-board` re-saved a board KiCad 10
  had not saved before. Without the save, the same rename was 46 lines. Save
  only when a refill must be written back, check the diff size before a commit,
  and compare copper as sets rather than lines after a save.
- **A sequential edit that moved items twice.** Spacing rows one at a time on
  shared coordinates moved one row's wires and labels onto the next. Move a set
  in one pass with a fixed mapping.
- **An interface "fix" proposed before reading its history.** On the r2 template
  family, bus pin 7 was named SYNC and pin 8 INT, the reverse of the backplanes
  and 25 other slices. The agent proposed swapping the copper. The history showed
  the copper had never changed, only the names, in one commit; the swap would
  have moved the interrupt line off an interrupt pin. The reviewer chose to
  rename only, and all seven boards kept the same pads on every net. Trace when
  an interface changed, what changed with it, and whether copper or only names
  differ, before proposing a fix.
- **A fleet change applied to some targets only.** Give a fleet change a list of
  targets, each ticked or explicitly excluded.

## Looking, not counting

Plotting the board with KiCad and looking at crops of each changed area caught
what every check passed:

- pin labels printed on new diagonal runs, an old label over a new route, and a
  logo over three new routes;
- a footprint reference written at board coordinates where the field takes
  footprint-relative ones, so it landed off the board, with no DRC change;
- J1's silkscreen naming SYNC and INT against the copper. No checker found
  compares silk text with the nets of the pads it labels.

## The review loop

The reviewer marked rendered images on a shared whiteboard; the agent read the
marks back as rows and fixed nothing until the readback was confirmed.

- **Worked:** renders on a whiteboard rather than a form (most of the feedback
  was spatial); reading each stroke back by drawing it over its source image
  from the board's own data; a readback page with a confirm or correct control
  on each row.
- **Did not:** of 34 readback rows, 8 were unsure, mostly strokes with no words;
  colour carried no meaning; one long marking session put every correction at
  the end.
- **Changed for round two:** a comment pinned to each mark; one colour per
  meaning (red defect, blue question, green keep); short sections, each read
  back before the next; the after-render placed beside the original mark; and
  the agent's own visual pass before the reviewer sees anything, so marks are
  about judgement rather than stair-steps.

## Where this points

Read against [`problems.md`](problems.md): T1's table is the clearest case in
this topic of cause 5 (the checks stop at what is easy to check), and T1 to T9
are cause 3 (geometry is the weak axis) answered by method rather than by a
model.

- **Skill.** T1 to T9 as techniques that keep their conditions and evidence, not
  as flattened rules; the working-practice lessons; the review loop.
- **boardwright,** in its issues, not decided here:
  - segments per net against the minimum the net needs (heibench/boardwright#138);
  - ratsnest crossings per placement;
  - placing a series part on its net's bare route, at the route's angle,
    staggered when courtyards meet: T1 as a placement verb, so the tool computes
    the geometry the agent got wrong by hand;
  - refilling, or warning, when added copper lands in another net's pour;
  - a copper comparison that tells a re-save from a real change;
  - naming a pour island and where a via would join it (T5);
  - tracks at their net-class width;
  - silk text against the nets of the pads it labels.
- **Guards over prose** for the working-practice lessons that repeated: an exit
  status that stops a chain, a SHA taken from command output, the CI gate run
  locally.

Already fixed in boardwright from the same work: the preview's connectivity
(#134), MOVE checked after RIPUP (#135), preview fills and hidden references
(#136), and `reroute` refusing to narrow wide tracks (#137).
