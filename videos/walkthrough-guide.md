# Video walkthrough guide

Each module includes a five-minute video script outline at `<module>/videos/<module>-script.md`. The optional walkthrough series demonstrates each module live in the Azure portal — useful for LinkedIn posts, YouTube uploads, conference talk pitches, or cover-letter video links.

This guide explains the structure, recording logistics, redaction rules, and publishing checklist.

## Why bother filming

Three reasons:

**Reason 1 — Recruiter signal.** A LinkedIn post linking a five-minute video gets ~5x the engagement of a text post linking the same GitHub repo. Recruiters scrolling LinkedIn during a hiring sprint will click a thumbnail and watch 30 seconds; they will not always click a GitHub link.

**Reason 2 — Interview preparation.** Recording yourself walking through a module forces you to articulate the design rationale out loud. By the time you finish 12 videos, you can talk about every concept in the portfolio without notes. The interview answer becomes muscle memory.

**Reason 3 — Long-term portfolio asset.** A YouTube channel with 12 well-produced Azure walkthroughs is a permanent career asset. It compounds across job changes. Some videos may pick up search traffic and bring the portfolio inbound visibility.

## Script structure (5 minutes total)

Every module video follows the same three-act structure:

```
0:00–0:30   Hook
0:30–2:00   Demo segment 1
2:00–3:30   Demo segment 2
3:30–4:30   Demo segment 3
4:30–5:00   Takeaway
```

**Hook (30 seconds).** State the problem the module solves and what the viewer will see. No introduction of yourself by name, no "today we're going to learn about" filler. Example for module 02: *"In this video I'll show you why the Contributor role can't assign permissions in Azure, and how to use User Access Administrator scoped narrowly to fix it. The whole demonstration takes five minutes and uses three commands."*

**Three demo segments (90 seconds each).** Each segment shows one concrete configuration step with the result. Screen recording with portal navigation visible. Voiceover explains what you're clicking and why. No idle time — if the portal is loading, cut it in editing.

**Takeaway (30 seconds).** One sentence of "what this means" and one sentence of "where to learn more." Point at the GitHub repo. Don't say "subscribe" — that's noise; if the content is good, viewers subscribe without prompting.

## Recording setup

**Audio.** Use a headset microphone or a USB condenser. Built-in laptop mics produce hollow audio that sounds amateur. A $50 USB condenser is the single highest-leverage upgrade.

**Screen recording.** macOS: QuickTime Player → File → New Screen Recording. Or use OBS Studio (free, more features). Record at 1080p 30fps minimum.

**Cursor visibility.** Enable a cursor highlight tool (free options: Mousepose, Cursor Highlighter on macOS). Viewers can't follow what you're clicking without it.

**Region / window.** Record only the Azure portal browser window, not the full screen. This avoids accidentally capturing your taskbar with personal app names.

**Pre-flight checklist before recording:**
- Close all browser tabs except the Azure portal
- Sign into a clean browser profile dedicated to the lab (not your personal browser with bookmarks visible)
- Set browser zoom to 110% or 125% so portal text is readable on phone screens
- Disable browser notifications
- Close Slack, email, anything that might pop up
- Check the URL bar — does it contain a subscription ID? If yes, blur in editing or navigate to a clean URL

## Redaction in video

Same rules as screenshots, applied frame-by-frame:

- Blur subscription IDs in URL bar
- Blur object IDs visible in role assignments
- Blur tenant IDs in any token output
- Don't read your real name on camera
- Don't show your home IP in named-locations screens — use a placeholder name like "Home (redacted)"
- If you accidentally show a real email address, cut and re-record that segment

Free editing tools that support blur: DaVinci Resolve (Mac/Windows), iMovie (Mac, blur via overlay), Shotcut.

## Publishing checklist

Before uploading any video:

- [ ] Watch full playback for blur misses
- [ ] Verify audio level is consistent (no segments much louder/quieter)
- [ ] Add captions — YouTube auto-captions are good enough; review and fix obvious errors
- [ ] Title format: `Azure Admin: <Module Topic> | Real lab walkthrough` (gets clicks; not clickbait)
- [ ] Description: 2-sentence summary, link to the GitHub module folder, link to the master GitHub repo
- [ ] Tags: `azure`, `azure administrator`, `cloud operations`, `<topic-specific>`
- [ ] Thumbnail: large readable text overlay describing the module — not a stock cloud photo
- [ ] Pin one comment with the GitHub link

## Don't film modules in numerical order

Counter-intuitive but true: film the modules you're most confident about first. Your first 2–3 videos will be rougher than later ones. Make those rough ones cover topics you can re-record easily if needed (modules 00, 01). Save module 11 (hybrid identity deployed) and module 10 (capstone) for last because they're the most differentiating and you want them at peak production quality.

## Filming cadence

Don't film while building. Film 1–2 weeks after completing the module — by then you understand the material well enough to teach it confidently. Set aside one Saturday per month for filming 2–3 modules in a batch. Edit the next day.

## Optional: cover-letter video link

For senior or competitive applications, a 60-second personal video referencing one specific module from the portfolio is high-leverage. Format: introduce yourself for 10 seconds, name the role you're applying for, then say *"I built a hands-on Azure portfolio. Here's my favorite 30 seconds of it."* Cut to one demonstration clip from your strongest module video. Post on Loom or YouTube unlisted; link in cover letter.

This is not necessary for the average application. It's a force-multiplier for top-of-funnel applications where the recruiter has 200 candidates and is looking for a reason to advance 20.

## Permissions

The Microsoft Azure portal is screen-recordable. Microsoft does not restrict capturing UI of services you have legitimately deployed in your own subscription. Don't record demos that include Microsoft Learn page content beyond fair-use brief excerpts. Don't claim to be a Microsoft employee or an MVP unless you are.

## What this guide does not cover

YouTube algorithm strategy, growth hacks, monetization. None of that matters for the portfolio's purpose. You're filming for hiring managers and yourself, not for a YouTube channel as a business. If a video happens to grow, that's bonus signal; if no video gets more than 50 views, that's still 50 hiring managers you reached.
