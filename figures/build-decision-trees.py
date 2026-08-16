#!/usr/bin/env python3
"""Build the decision-tree figures for Chapter 24.

The geometry is defined ONCE, in `tree_skeleton()`. Each figure is that
same skeleton with different text and different chance-node treatment,
so the two versions of the coaching tree cannot drift apart when one is
edited. Run from the project root:

    python3 figures/build-decision-trees.py

Outputs (committed, so the book has no build-time dependency on this):
    figures/decision-tree-classical.svg
    figures/decision-tree-draws.svg
    figures/decision-tree-staged.svg

House style, per BOOK_PLAN.md 1c:
    navy   #122a52  the heaviest weight on the page
    mid    #3d68a8  secondary navy
    light  #8fabd0  de-emphasised
    amber  #8a5a00  descriptive markers
    red    #d32f2f  reserved: the thing an estimate is argued against
    grey   #b8bcc4  never darker than grey70 next to navy

Background is left transparent so the figures sit on the page colour.
"""

from pathlib import Path

NAVY = "#122a52"
MID = "#3d68a8"
LIGHT = "#8fabd0"
AMBER = "#8a5a00"
RED = "#d32f2f"
GREY = "#b8bcc4"
FONT = "Inter, -apple-system, 'Segoe UI', Helvetica, Arial, sans-serif"

OUT = Path(__file__).parent


# --------------------------------------------------------------------
# primitives
# --------------------------------------------------------------------

def decision_node(x, y, s=13):
    """Square. A choice the analyst or the business makes."""
    return (f'<rect x="{x - s}" y="{y - s}" width="{2 * s}" height="{2 * s}" '
            f'rx="2" fill="{NAVY}"/>')


def chance_node(x, y, r=13):
    """Circle. Something uncertain resolves."""
    return (f'<circle cx="{x}" cy="{y}" r="{r}" fill="none" '
            f'stroke="{NAVY}" stroke-width="2.5"/>')


def payoff_node(x, y, s=12):
    """Triangle. An ending, with a value attached."""
    return (f'<polygon points="{x - s},{y - s} {x + s},{y} {x - s},{y + s}" '
            f'fill="{MID}"/>')


def branch(x1, y1, x2, y2, colour=NAVY, width=2, dash=None, opacity=1.0):
    d = f' stroke-dasharray="{dash}"' if dash else ""
    return (f'<path d="M {x1} {y1} L {x2} {y2}" fill="none" stroke="{colour}" '
            f'stroke-width="{width}" stroke-opacity="{opacity}"{d}/>')


def text(x, y, s, size=13, colour=NAVY, weight="400", anchor="start",
         style="normal"):
    s = (s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;"))
    return (f'<text x="{x}" y="{y}" font-family="{FONT}" font-size="{size}" '
            f'font-weight="{weight}" font-style="{style}" fill="{colour}" '
            f'text-anchor="{anchor}">{s}</text>')


def label_on_branch(x1, y1, x2, y2, frac, offset, s, **kw):
    """Put text a fraction of the way along a branch, offset perpendicular
    to it. Fixed-y labels collide the moment a branch angle changes; this
    does not."""
    import math
    px, py = x1 + (x2 - x1) * frac, y1 + (y2 - y1) * frac
    dx, dy = x2 - x1, y2 - y1
    n = math.hypot(dx, dy) or 1
    # unit normal, pointing "up" relative to the branch direction
    nx, ny = -dy / n, dx / n
    return text(px + nx * offset, py + ny * offset + 4, s, **kw)


def svg(width, height, body):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {width} {height}" '
            f'width="{width}" height="{height}" role="img">\n'
            + "\n".join(body) + "\n</svg>\n")


# --------------------------------------------------------------------
# the shared skeleton
# --------------------------------------------------------------------

# Coordinates used by both versions of the coaching tree.
X_DECISION = 76
X_CHANCE = 286
X_END = 560
Y_MID = 170
Y_COACH = 108
Y_DONT = 286
Y_BRANCH = (44, 108, 172)     # three outcome endpoints on the coach branch
CANVAS = (860, 430)


def tree_skeleton(fan=False):
    """The coaching decision, drawn once.

    fan=False  discrete branches, the classical drawing
    fan=True   a band of many paths, the draws version
    """
    b = []

    # the two actions
    b.append(branch(X_DECISION + 13, Y_MID, X_CHANCE - 13, Y_COACH))
    b.append(branch(X_DECISION + 13, Y_MID, X_END - 12, Y_DONT))

    if fan:
        # many paths, suggesting draws rather than branches
        for i in range(28):
            t = i / 27
            y = Y_BRANCH[0] - 14 + t * (Y_BRANCH[2] - Y_BRANCH[0] + 30)
            b.append(branch(X_CHANCE + 13, Y_COACH, X_END - 26, y,
                            colour=MID, width=1.1, opacity=0.30))
    else:
        for y in Y_BRANCH:
            b.append(branch(X_CHANCE + 13, Y_COACH, X_END - 12, y))

    # nodes last, so they sit over the lines
    b.append(decision_node(X_DECISION, Y_MID))
    b.append(chance_node(X_CHANCE, Y_COACH))
    b.append(payoff_node(X_END, Y_DONT))
    if not fan:
        for y in Y_BRANCH:
            b.append(payoff_node(X_END, y))
    return b


def legend(x, y):
    """Shape key. Standard decision-analysis notation, worth teaching once."""
    b = [text(x, y - 16, "Reading the shapes", size=11, colour=AMBER,
              weight="600")]
    items = [(decision_node, "square = a choice you make"),
             (chance_node, "circle = something uncertain resolves"),
             (payoff_node, "triangle = an ending, with a value")]
    for i, (shape, label) in enumerate(items):
        yy = y + i * 25
        b.append(shape(x + 10, yy, 8) if shape is not chance_node
                 else shape(x + 10, yy, 8))
        b.append(text(x + 28, yy + 4, label, size=11.5, colour=NAVY))
    return b


# --------------------------------------------------------------------
# figure 1 — the classical tree
# --------------------------------------------------------------------

def classical():
    b = ['<title>The coaching decision as a classical decision tree</title>']
    b += tree_skeleton(fan=False)

    # Decision label sits ABOVE the node, not beside it - beside it runs
    # off the left edge as soon as the wording gets longer.
    b.append(text(X_DECISION, Y_MID - 40, "Coach this", size=13,
                  weight="600", anchor="middle"))
    b.append(text(X_DECISION, Y_MID - 24, "manager?", size=13,
                  weight="600", anchor="middle"))

    b.append(label_on_branch(X_DECISION + 13, Y_MID, X_CHANCE - 13, Y_COACH,
                             0.45, 14, "Yes", size=12.5, weight="600",
                             anchor="middle"))
    b.append(label_on_branch(X_DECISION + 13, Y_MID, X_END - 12, Y_DONT,
                             0.30, -16, "No", size=12.5, weight="600",
                             anchor="middle"))

    b.append(text(X_CHANCE, Y_COACH - 40, "How well", size=11.5,
                  colour=MID, anchor="middle"))
    b.append(text(X_CHANCE, Y_COACH - 26, "does it work?", size=11.5,
                  colour=MID, anchor="middle"))

    labels = [("0.25", "Upper quartile: 35% fewer transfers"),
              ("0.50", "Median: 20% fewer"),
              ("0.25", "Lower quartile: 12% fewer")]
    # The normal points *below* a left-to-right branch, so a negative
    # offset lifts a label above its line. The three branches converge at
    # the node, so a uniform offset stacks two labels on top of each other:
    # the outer two go above, the bottom one below.
    for (prob, lab), y, off in zip(labels, Y_BRANCH, (-14, -14, 14)):
        b.append(label_on_branch(X_CHANCE + 13, Y_COACH, X_END - 12, y,
                                 0.45, off, prob, size=12, colour=AMBER,
                                 weight="600", anchor="middle"))
        b.append(text(X_END + 20, y + 4, lab, size=12))

    b.append(text(X_END + 20, Y_DONT + 4,
                  "Nothing changes, nothing spent: £0", size=12))

    b.append(text(X_END + 20, 224,
                  "Each payoff = rate × team size × reduction", size=11.5,
                  colour=AMBER, style="italic"))
    b.append(text(X_END + 20, 240,
                  "× net cost per departure − £4,000 fee", size=11.5,
                  colour=AMBER, style="italic"))

    b += legend(76, 352)
    return svg(*CANVAS, b)


# --------------------------------------------------------------------
# figure 2 — the same tree, run on draws
# --------------------------------------------------------------------

def histogram(x, y, w=104, h=54):
    """A small distribution glyph standing in for the posterior of net benefit."""
    heights = [0.10, 0.22, 0.40, 0.62, 0.86, 1.00, 0.94, 0.72, 0.50, 0.32,
               0.19, 0.10, 0.05]
    bw = w / len(heights)
    b = []
    for i, hh in enumerate(heights):
        bh = hh * h
        b.append(f'<rect x="{x + i * bw:.1f}" y="{y - bh:.1f}" '
                 f'width="{bw - 1.4:.1f}" height="{bh:.1f}" fill="{LIGHT}"/>')
    # break-even line: the one thing the distribution is argued against
    b.append(f'<path d="M {x + 3.1 * bw:.1f} {y - h - 8} L {x + 3.1 * bw:.1f} {y + 5}" '
             f'stroke="{RED}" stroke-width="1.6" stroke-dasharray="4 3"/>')
    b.append(text(x + 3.1 * bw, y + 19, "£0", size=10.5, colour=RED,
                  anchor="middle"))
    return b


def draws():
    b = ['<title>The same decision tree run on posterior draws</title>']
    b += tree_skeleton(fan=True)

    b.append(text(X_DECISION, Y_MID - 40, "Coach this", size=13,
                  weight="600", anchor="middle"))
    b.append(text(X_DECISION, Y_MID - 24, "manager?", size=13,
                  weight="600", anchor="middle"))

    b.append(label_on_branch(X_DECISION + 13, Y_MID, X_CHANCE - 13, Y_COACH,
                             0.45, 14, "Yes", size=12.5, weight="600",
                             anchor="middle"))
    b.append(label_on_branch(X_DECISION + 13, Y_MID, X_END - 12, Y_DONT,
                             0.30, -16, "No", size=12.5, weight="600",
                             anchor="middle"))

    b.append(text(X_CHANCE, Y_COACH - 40, "4,000 draws,", size=11.5,
                  colour=MID, anchor="middle"))
    b.append(text(X_CHANCE, Y_COACH - 26, "not three branches", size=11.5,
                  colour=MID, anchor="middle"))

    # what each path is made of, parked in the empty lower-left quadrant
    b.append(text(76, 336, "Each path multiplies one draw from each of:",
                  size=11.5, colour=AMBER, weight="600"))
    for i, (src, what) in enumerate([
            ("posterior", "the manager\u2019s transfer rate"),
            ("elicited", "the reduction coaching achieves"),
            ("elicited", "the net cost of one departure")]):
        yy = 358 + i * 19
        b.append(text(88, yy, f"\u2022 {what}", size=11.5))
        b.append(text(330, yy, f"({src})", size=11, colour=MID,
                      style="italic"))

    b += histogram(X_END + 30, 150)
    b.append(text(X_END + 30, 44, "A posterior for net benefit,", size=12,
                  weight="600"))
    b.append(text(X_END + 30, 60, "not a single expected value", size=12,
                  weight="600"))
    b.append(text(X_END + 30, 196,
                  "Read it for how often coaching pays,", size=11.5,
                  colour=MID, style="italic"))
    b.append(text(X_END + 30, 212, "and how badly it doesn\u2019t",
                  size=11.5, colour=MID, style="italic"))

    b.append(text(X_END + 20, Y_DONT + 4,
                  "Nothing changes, nothing spent: £0", size=12))
    return svg(*CANVAS, b)


# --------------------------------------------------------------------
# figure 3 — the staged decision, where option value comes from
# --------------------------------------------------------------------

def staged():
    """Part 6. A different shape from the coaching tree: the second square
    is the whole point, so the geometry is its own rather than shared."""
    XD1, XC, XD2, XE = 90, 290, 470, 640
    YM, YUP, YDN = 200, 120, 330
    Y_GOOD, Y_BAD = 60, 170

    b = ['<title>A staged decision: pilot first, keep the right to stop</title>']

    b.append(branch(XD1 + 13, YM, XE - 12, YDN))
    b.append(branch(XD1 + 13, YM, XC - 13, YUP))
    b.append(branch(XC + 13, YUP, XD2 - 13, Y_GOOD))
    b.append(branch(XC + 13, YUP, XD2 - 13, Y_BAD))
    b.append(branch(XD2 + 13, Y_GOOD, XE - 12, Y_GOOD))
    b.append(branch(XD2 + 13, Y_BAD, XE - 12, Y_BAD, colour=GREY, dash="5 4"))

    b.append(decision_node(XD1, YM))
    b.append(chance_node(XC, YUP))
    b.append(decision_node(XD2, Y_GOOD))
    b.append(decision_node(XD2, Y_BAD))
    for y in (Y_GOOD, Y_BAD, YDN):
        b.append(payoff_node(XE, y))

    b.append(text(XD1, YM - 40, "How much do", size=13, weight="600",
                  anchor="middle"))
    b.append(text(XD1, YM - 24, "we commit?", size=13, weight="600",
                  anchor="middle"))

    b.append(label_on_branch(XD1 + 13, YM, XC - 13, YUP, 0.50, -16,
                             "Pilot 30 managers", size=12.5, weight="600",
                             anchor="middle"))
    b.append(label_on_branch(XD1 + 13, YM, XE - 12, YDN, 0.42, -25,
                             "Commit the whole budget now", size=12.5,
                             weight="600", anchor="middle"))

    b.append(text(XC, YUP - 54, "What the", size=11.5, colour=MID,
                  anchor="middle"))
    b.append(text(XC, YUP - 40, "pilot shows", size=11.5, colour=MID,
                  anchor="middle"))

    b.append(label_on_branch(XC + 13, YUP, XD2 - 13, Y_GOOD, 0.64, -13,
                             "It works", size=11.5, colour=AMBER,
                             weight="600", anchor="middle"))
    b.append(label_on_branch(XC + 13, YUP, XD2 - 13, Y_BAD, 0.64, 13,
                             "It doesn\u2019t", size=11.5, colour=AMBER,
                             weight="600", anchor="middle"))

    b.append(text(XE + 20, Y_GOOD + 4,
                  "Roll out to everyone \u2014 keep the upside", size=12))
    b.append(text(XE + 20, Y_BAD + 4,
                  "Stop \u2014 the downside is truncated here", size=12))
    b.append(text(XE + 20, YDN + 4, "Whatever happens, happens", size=12))
    b.append(text(XE + 20, YDN + 20, "no second chance to choose", size=12,
                  colour=MID, style="italic"))

    # Parked in the clear band on the right, between the two lower endings.
    b.append(text(XE + 20, 250, "The option lives in this second square.",
                  size=11.5, colour=AMBER, weight="600"))
    b.append(text(XE + 20, 268,
                  "Remove it \u2014 no probation, no way to stop \u2014",
                  size=11.5, colour=AMBER))
    b.append(text(XE + 20, 286,
                  "and the top branch collapses onto the bottom.",
                  size=11.5, colour=AMBER))

    return svg(1010, 380, b)


# --------------------------------------------------------------------

if __name__ == "__main__":
    for name, fn in [("decision-tree-classical", classical),
                     ("decision-tree-draws", draws),
                     ("decision-tree-staged", staged)]:
        path = OUT / f"{name}.svg"
        path.write_text(fn(), encoding="utf-8")
        print(f"wrote {path} ({path.stat().st_size:,} bytes)")
