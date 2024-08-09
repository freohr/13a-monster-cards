# 13th Age Monster Cards

A basic LaTeX class to generate printable monster cards for the 13th Age RPG.

With this class, the generated cards will be displayed in A6 format 4 by 4 in a A4 portrait page.

## How to use

For now, the following instructions assume that you know the basics of LaTeX document generation (i.e. you have a LaTeX distribution installed on your system, you know the basic structure of a LaTeX document, and you know which command to call to generate the final PDF document)

1. Download the [class file](./13a-monster-card.cls) and put in a dedicated work folder (where you will put your document file for the card generation)
2. Use `13a-monster-card` as the document class
3. Write the monster stablocks using the following provided commands
4. Generate the pdf document using your distribution of choice (I like [tectonic](https://tectonic-typesetting.github.io/en-US/))
5. Print the cards
6. Cut them up and use them as reference at your table

### Provided commands

- `\monsterCard{<monster-info>}`: the base command. Use it to declare a new monster card, then put all the monster info in the first parameter

Then, in logical order based on the official monster block layout from the 13th Age RPG. Note that the kind of braces is important: Curly braces are mandatory, and Brackets are optional but must be provided blank if you need to specify further parameters.

If a block is not present in the original statblock, you can simply skip the associated command (e.g. no vulnerabilities or no traits)

- `\monsterName{<name>}`: the name of the monster
- `\monsterType{<level>}{<role>}{<type>}[<size>][<strength>][<mook>]`:
  - `<level>`: the integer level of the monster. The cardinal suffix is automatically appended, do not include it
  - `<role>`: The supplied role of the monster. When using the 1st Edition monster, if it not supplied (e.g. for mooks), leave this field empty, it will be set to `troop` automatically
  - `<type>`: the type of the monster (e.g. Humanoid, Plant, Giant, etc.)
  - `<size>` [Optional]: the size of the monster (Normal, Large, Huge).
  - `<strength>` [Optional]: the strength of the monster (Weakling, Normal, Double-Strength, Triple-Strength)
    - Note from the 2nd Edition: The current Gamma packet of 13th Age Second Edition splits size and strength into separate fields, whereas 1e used them interchangeably. If you're creating a card based on a 1e monster, just supply the corresponding field and leave the other blank.
    - Second note: `Normal` is the default size and strength for monster, and is usually implied, so you don't need to provide either field in this case.
  - `<mook>` [Optional]: Whether the monster is a mook. This is a boolean field, and the command simply checks whether is it supplied, so you can simply write `m` to indicate a mook.
    - Note from the 2nd Edition: Like `<size>` and `<strength>`, the 2nd Edition Gamma rules have split the monster role and whether it is a mook. If you're creating a card based on a 1e monster, just leave the role parameter blank (or write down the most relevant one if you prefer), and fill this field to indicate a mook.
- `\initiative{<initiative>}`: the initiative value for the monster
- `\vulnerabilities{<vulnerabilities>}`: the list of vulnerabilities for the monster
- `\actions{<action-list>}`: the enclosing command for the monster's action list. Write down the monster's actions as a parameter one per line using the next command.
- `\action{<name>}{<effect>}[<traits>]`: a single action for the monster:
  - `<name>`: the action name, including the hit roll bonus and the targeted defenses (usually everything before the em-dash in the formatted statblock)
  - `<effect>`: the action effect on a hit (usually everything after the em-dash)
  - `<traits>` [Optional]: the list of traits associated with the action, listed one per line using the following `\trait` command
- `\traits{<trait-list>}`: the enclosing command for the monster's trait list. Write down the monster's traits as a parameter one per line using the next command. Provided separate from the `\actions` command for logical organization, but functionnally identical.
- `\trait{<name>}{<effect>}`: a single trait for the monster
  - `<name>` the trait name, usually everything before the colon in the formatted statblock
  - `<effect>` the trait effect, usually everything after the colon. Note that in case of elaborate traits, you can take advantage of plain LaTeX to write them.
- `\triggeredActions{<action-list>}`: the enclosing command for the monster's triggered action list. Similar to `\actions`, with a prepended "Triggered Actions" header.
- `\nasterTraits{<trait-list>}`: the enclosing command for the monster's nastier specials list. Similar to `\traits`, with a prepended "Nastier Specials" header.
- `\monsterDefenses{<AC>}{<PD>}{<MD>}{<HP>}`: the monster's defenses and HP.

## Potential Evolutions

- A smaller A7 format for really simple statblocks
- A larger A5 format for more complicated statlocks
- A letter-sized layout for printing
- Setup a package and submit it to CTAN
- ~~Setup a web page to parse statblock and automatically output the corresponding LaTeX block, based on my [existing parser](https://github.com/freohr/obsidian-13A-monster-parser) for Obsidian and Foundry~~ -> Done, see [the Monster Reformatter](https://freohr.github.io/13a-monster-reformatter/)
