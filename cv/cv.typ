#import "education.typ": education_entry
#import "skill_entries.typ": skill_entries
#import "pubcontrib.typ": public_contributions_entries

#let cv_header(
    name: "Golovach Lena", 
    title: "Senior Pomidor", 
    agenda: "I'm super passionate developer with Web3 intentions",
    color: eastern,
) = {
    set par(leading: 0.3em, justify: true, linebreaks: auto)
    let nname = block(text(font: "FiraCode Nerd Font Mono", size: 25pt, weight: "extrabold", )[
        #name
    ])
    let ntitle = block(
            text(
                font: "Rockwell", 
                size: 12pt, 
                style: "italic",
                weight: "extrabold",
                fill: color.lighten(0%)
            )[#title]
        )
    let nagenda = block(text(size: 8pt, weight: "light")[#agenda])

    block()[
        #nname
        #ntitle
        #nagenda
    ]
}

#let job_entry(
    job,
    hack_font,
    curvy_font: "Rockwell",
    main_color: eastern,
) = {
    let place = if job.at("company_url", default: none) != none {
        link(job.company_url)[
            #text(
                font: hack_font, 
                weight: "extrabold",
                size: 12pt, 
                style: "italic", 
            )[#job.company]
        ]        
    } else {
        text(
            font: curvy_font, 
            size: 12pt,
            style: "italic", 
            // fill: main_color.lighten(30%)
        )[#job.company]
    }

    let period = block(width: 100%)[
        #align(
            end,
            text(
                font: hack_font, size: 8pt, weight: "bold"
            )[
                #job.start_date.display("[month repr:long] [year repr:full]")
                #raw("-")  
                #if job.at("end_date", default: none) != none [
                    #job.end_date.display("[month repr:long] [year repr:full]")
                ] else [Present]
            ]
        )
    ]

    block(
        width: 100%,
        radius: 3pt,
        outset: 8pt,
        inset: 0pt, 
        fill: white,
        stroke: (
            thickness: 3pt,
            paint: main_color.lighten(90%),
            cap: "butt",
            dash: "dashed"
        ),
    )[
        #set par(leading: 0.3em, justify: true, linebreaks: "optimized")
        #block(below: 0.3em)[#grid(
            columns: 2,
            rows: 1,
            place,
            period,
        )]
        #block(below: 0.3em)[#text(
            font: curvy_font, 
            size: 9pt, 
            style: "italic",
            fill: main_color.lighten(0%),
            weight: "extrabold"
        )[#job.title]]
        #show list: set list(tight: true, spacing: 0.3em)
        #if job.at("summary", default: none) != none [
            #text(size: 8pt, weight: "light")[#job.summary]
        ]
        #for highlight in job.highlights [
            - #text(size: 8pt, weight: "light")[#highlight]
        ]
    ]
}

#let jobs_entry(
    jobs: (), 
    hack_font,
) = {
    let color = eastern
    let jobs_blocks = for job in jobs [
        #job_entry(job, hack_font)
    ]

    block(
        width: 100%,
        height: 100%,
        radius: 3pt,
        outset: 8pt,
        inset: 4pt, 
        fill: color.lighten(90%),
    )[#jobs_blocks]
}

#let cv_contact(
    email: none,
    mobile: none,
    linkedin: none,
    github: none,
    website: none,
    location: none,
    color: eastern,
) = {
    let spacing = 7pt
    let font = "FiraCode Nerd Font Mono"
    show link: underline
    block(
        radius: 3pt,
        outset: 8pt,
        inset: 0pt,
        fill: color.lighten(90%),
        width: 100%
    )[
        #if email != none {
            block(spacing: spacing)[
                #text(font: font, size: 8pt, weight: "bold")[Email: ]
                #text(size: 9pt, weight: "light", stretch: 100%)[#link("mailto:"+email)]
            ]
            
        }
        #if mobile != none {
            block(spacing: spacing)[
                #text(font: font, size: 8pt, weight: "bold")[Phone: ]
                #text(size: 9pt, weight: "light", stretch: 100%)[#link("tel:"+mobile)]
            ]
            
        }
        #if linkedin != none {
            block(spacing: spacing)[
                #text(font: font, size: 8pt, weight: "bold")[LinkedIn: ]
                #text(size: 9pt, weight: "light", stretch: 100%)[#link("https://linkedin.com/in/"+linkedin)[#linkedin]]
            ]
            
        }
        #if github != none {
            block(spacing: spacing)[
                #text(font: font, size: 8pt, weight: "bold")[GitHub: ]
                #text(size: 9pt, weight: "light", stretch: 100%)[#link("https://github.com/"+github)[#github]]
            ]
        }
        #if website != none {
            block(spacing: spacing)[
                #text(font: font, size: 8pt, weight: "bold")[Website: ]
                #text(size: 8pt, weight: "light", stretch: 100%)[#link(website)]
            ]
        }
        #if location != none {
            block(spacing: spacing)[
                #text(font: font, size: 8pt, weight: "bold")[Location: ]
                #text(size: 9pt, weight: "light", stretch: 100%)[#location]
            ]
        }
    ]
}

#let cv(
    name: "Golovach Lena",
    title: "Senior Pomidor",
    summary: "I am actively seeking perfect opportunities to apply my knowledge in ML-backed and high-load/Big Data projects.",
    jobs: (),
    skills: (),
    education: (),
    public_contributions: (),
    hack_font: "FiraCode Nerd Font Mono",
    curvy_font: "Rockwell",
    main_color: eastern
) = {
    set page(paper: "a4", margin: (x: 20pt, y: 20pt))
    set par(justify: true, linebreaks: "simple")
    set text(font: "PT Sans", stretch: 80%)
    grid(
        columns: (2fr, 1fr),
        rows: (auto, 1fr),
        column-gutter: 16pt,
        row-gutter: 16pt,
        cv_header(
            name: name, 
            title: title, 
            agenda: summary,
        ),
        cv_contact(
            email: "rubinsteindb@gmail.com",
            mobile: "054-357-69-69",
            linkedin: "virviil",
            github: "virviil",
            website: "https://ilhub.io",
            location: "Ramat Gan, Center",
            color: main_color,
        ),
        jobs_entry(jobs: jobs, hack_font),
        block(
            width: 100%,
            height: 100%,
            radius: 3pt,
            outset: 8pt,
            inset: 4pt,
        )[
            #skill_entries(skills)
            #education_entry(education, hack_font)
            #public_contributions_entries(public_contributions)
        ],
    )
}
