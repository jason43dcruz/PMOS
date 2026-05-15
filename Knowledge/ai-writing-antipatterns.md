# AI Writing Antipatterns — What to Avoid

<!-- Reference list of commonly used AI-style writing tics. Use alongside writing-style.md and write-like-me.md to catch and kill robotic phrasing. -->

## Why This Exists

LLMs have tells. When AI drafts something for you and the output "sounds like AI," it's usually because of specific word choices, sentence structures, and rhetorical habits that appear constantly in model outputs but rarely in natural human writing. This list catches the most common ones.

## Words and Phrases to Kill on Sight

### The "AI Intensifiers"

These words appear 10–50x more often in AI writing than in human writing. They're the biggest tells.

| Kill | Replace with |
|---|---|
| delve / delve into | look at, dig into, explore |
| utilize | use |
| leverage (verb) | use, build on |
| moreover | also, and |
| furthermore | also, and, on top of that |
| it's worth noting that | (just say the thing) |
| it's important to note | Note that... |
| in the realm of | in |
| in the context of | for, when it comes to |
| a myriad of | many, a lot of |
| a plethora of | many, a lot of |
| multifaceted | complex, has a few dimensions |
| nuanced | (be specific about what makes it nuanced) |
| pivotal | important, key |
| crucial | important, key |
| foster | build, create, encourage |
| harness | use, apply |
| bolster | strengthen, support |
| underscore | show, highlight |
| navigate (abstract) | deal with, work through, handle |
| landscape (abstract) | market, space, world |
| paradigm | model, approach |
| synergy | (describe the actual benefit) |
| streamline | simplify, speed up |
| empower | enable, let, help |
| unlock | enable, open up |
| spearhead | lead, drive |
| endeavor | effort, work, try |
| embark on | start, begin |
| facilitate | help, enable, make easier |
| elucidate | explain, clarify |
| juxtapose | compare, contrast |
| interplay | relationship, interaction |
| testament to | shows, proves |

### The "AI Connectors"

Transition words and phrases AI overuses to sound structured.

| Kill | Replace with |
|---|---|
| that said | but, however (sparingly) |
| that being said | but |
| with that in mind | so |
| in light of this | so, because of this |
| this underscores | this shows |
| this highlights | this shows |
| moving forward | next, going forward (sparingly) |
| on the other hand | but |
| in terms of | for, regarding |
| when it comes to | for, with |
| at the end of the day | ultimately (or just cut it) |
| by the same token | similarly, also |
| it goes without saying | (then don't say it) |
| needless to say | (then don't say it) |
| as previously mentioned | (just reference it or link to it) |
| in a nutshell | (just be concise from the start) |

### The "AI Adjectives"

Adjectives AI uses to make everything sound impressive. They mean nothing.

- robust
- comprehensive
- cutting-edge
- innovative
- holistic
- seamless
- groundbreaking
- state-of-the-art
- transformative
- dynamic
- scalable (when not talking about actual systems)
- actionable (when every insight should be actionable)
- impactful
- best-in-class
- world-class
- mission-critical (usually it isn't)
- game-changing
- next-generation

### The "AI Conclusions"

How AI wraps things up. Always the same shape.

| Kill | What to do instead |
|---|---|
| "In conclusion..." | Just end. The last paragraph IS the conclusion. |
| "To summarize..." | Don't. If you wrote clearly, it's already summarised. |
| "Overall, it is clear that..." | State the specific takeaway. |
| "By doing X, we can Y" | Say what specifically changes and for whom. |
| "This represents a significant opportunity" | Quantify it. Say "$X at stake" or "Y customers affected." |
| "The key takeaway is..." | Just state the takeaway. |

## Rhetorical Tics and Punctuation Tells

### The "It's Not X, It's Y" Formula
> ❌ "It's not a pricing problem — it's a packaging problem."
> ❌ "This isn't about features. It's about trust."
> ❌ "The issue isn't capacity — it's capability."

AI loves this construction. It sounds punchy the first time. By the third time in a doc, it's a pattern. Humans occasionally use this, but AI uses it in nearly every analysis. If you catch yourself using it more than once per page, rewrite the others.

> ✅ "Packaging is the real issue, not pricing."
> ✅ "The gap is in capability — we have the capacity."

### Em Dash Overuse (—)
AI scatters em dashes everywhere — in every paragraph — sometimes twice in the same sentence — as if regular commas and full stops don't exist.

Humans use em dashes occasionally for emphasis or an aside. AI uses them as a default connector. Rules of thumb:
- **One em dash per paragraph max.** If you have more, replace the extras with commas, full stops, or parentheses.
- **Never two em dashes in the same sentence.** Pick one break point.
- Colons and semicolons exist. Use them.

> ❌ "The data is clear — win rates are low — and the root cause is product gaps — specifically CMDB and reporting."
>
> ✅ "The data is clear: win rates are low, and the root cause is product gaps in CMDB and reporting."

### The "Let's Break This Down" Move
> ❌ "Let's break this down."
> ❌ "Let's unpack this."
> ❌ "Let me walk you through this."

Just present the information. The reader knows you're about to explain something — that's why they're reading.

### The Dramatic One-Liner Paragraph

AI loves dropping a short, punchy sentence as its own paragraph for emphasis.

> ❌ "And that changes everything."
> ❌ "This is the real story."
> ❌ "That's a problem."

Once per doc, maybe. AI does this every few paragraphs. It loses its punch fast.

### The "Not Just X, But Y" / "Not Only X, But Also Y"
> ❌ "This is not just a product gap — it's a strategic risk."
> ❌ "We're not only losing deals, but also losing credibility."

Close cousin of "It's not X, it's Y." Same energy, same overuse. Say what matters first and skip the rhetorical setup.

> ✅ "This is a strategic risk, not just a product gap."

### The Colon-Into-List Setup
> ❌ "There are three things to consider here:"
> ❌ "The data tells us several things:"
> ❌ "This breaks down into three categories:"

AI always announces lists before giving them. Humans usually just start the list, or at most say "Three things:" without the preamble.

### Bolding Every Other Phrase
AI bolds **key terms**, **important concepts**, **strategic priorities**, and **critical findings** until the page is more bold than not. If everything is emphasised, nothing is. Bold the one thing that matters per paragraph.

### The Parenthetical Percentage Aside
> ❌ "Most customers (78%) never expand beyond IT."
> ❌ "Win rates dropped significantly (from 48% to 28%)."

This isn't wrong — you do this yourself — but AI does it in every single sentence with a number. Vary the structure. Sometimes lead with the number. Sometimes put it in a table. Sometimes just round it: "roughly 4 in 5 customers."

### Semicolons as List Separators in Running Text
> ❌ "The gaps include CMDB maturity; reporting depth; change management workflows; and identity architecture."

Use a proper bullet list, or just commas. Semicolons in running text are a mild AI tell.

## Structural Patterns to Avoid

### The "Three-Adjective Opening"
> ❌ "In today's rapidly evolving, increasingly complex, and highly competitive market..."

Nobody writes like this. Start with a fact, a number, or what happened.

### The "Acknowledging Complexity" Stall
> ❌ "This is a multifaceted challenge that requires a nuanced approach balancing multiple considerations..."

This says nothing. Name the actual tradeoffs.

### The "Exhaustive Bullet List" Problem
AI loves to list every possible consideration equally. Humans prioritise. If you have 12 bullets, you probably have 3 that matter and 9 that don't. Cut the 9.

### The "On One Hand / On the Other Hand" Hedge
> ❌ "On one hand, X offers significant benefits. On the other hand, there are challenges to consider."

Take a position. Say what you actually think, then name the risk.

### The "Let Me Restate What You Said" Opening
> ❌ "Great question! The topic of enterprise upgrade win rates is indeed an important one..."

Skip the throat-clearing. Answer the question.

### The "Certainly!" and "Absolutely!" Opener
> ❌ "Certainly! I'd be happy to help with that."
> ❌ "Absolutely! Let me break this down for you."

Just do the thing.

### The "Here's a Summary of What We Discussed"
AI loves to recap everything at the end. If the reader just read it, they don't need a summary. End with the action or the decision.

## The Smell Test

Read the draft aloud. If it sounds like:
- A LinkedIn post → too many buzzwords
- A consulting deck → too many frameworks, not enough specifics
- A press release → too positive, no tradeoffs named
- A textbook → too even-handed, no point of view

Then rewrite it like you're explaining it to a smart colleague over coffee.

## One Rule to Remember

**If a sentence could appear in literally any company's strategy doc with zero changes, it's not saying anything.** Make it specific to your situation, your data, your customers.

> ❌ "We need to deliver a seamless, best-in-class experience that empowers our customers."
>
> ✅ "78% of IT tenants have never created an ESM project. We need to nudge them at 90 days post-IT-go-live."
