+++
title = "D&D Armour Class Analysis"
date = 2020-06-27T01:16:11+01:00
draft = false
+++

### inspiration

I am rolling a Firbolg Cleric for a D&D campaign. Firbolgs consider armour and shields to be cowardly, and the cost of this cowardice is a staggeringly low armour class (hereafter referred to as AC.)

As I was deciding whether to give into this peer pressure and wear no armour whatsoever, I felt briefly motivated to see just what kind of an effect your AC has in various combat circumstances.

I'm not much of a data scientist. I know about stochastic analysis, and I know how to put a line onto a graph with matplotlib. That'll do for now.

### graphs

![Varying attack modifier](/img/varying-hitmod.png)

![Varying damage modifier](/img/varying-dmgmod.png)

![Varying number of damage dice](/img/varying-ndice.png)

![Varying type of damage dice](/img/varying-nsides.png)

It's clear that, for any configuration of attacker you're up against, your armour class gets exponentially more effective as it increases.

In other words, higher armour class is better. Who knew?
