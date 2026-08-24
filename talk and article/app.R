# ---------------------------------------------------------------------------
# Elicit — a lightweight prior elicitation app for stakeholder meetings
#
# Companion to "Bayesian Statistics for People Analytics", Chapter 23.
# Runs the quartile method with a live feedback loop, so the person you are
# eliciting from can see what their three answers imply and correct them
# before the number goes anywhere near a model.
#
#   install.packages(c("shiny", "SHELF", "ggplot2"))
#   shiny::runApp("app.R")
#
# Design notes (deliberate, not accidental):
#   * The plausible LIMITS are asked first and the other inputs stay locked
#     until they are given. Asking for a central estimate first anchors
#     everything after it. The app enforces the order so you cannot get it
#     wrong in front of a stakeholder.
#   * The feedback table marks the quantiles the expert DID give and the ones
#     the fit invented. The invented ones are the useful ones to read back.
#   * "Shade a region" answers the question a stakeholder actually asks —
#     "what's the chance it's above X" — from draws, not from a formula.
#   * Bounded families are offered explicitly, because the closest fit to three
#     points is often unbounded and will produce impossible values.
# ---------------------------------------------------------------------------

library(shiny)
library(SHELF)
library(ggplot2)

# Book palette (Chapter 4 convention) -----------------------------------------
NAVY       <- "#122a52"
NAVY_MID   <- "#3d68a8"
NAVY_LIGHT <- "#8fabd0"
RED        <- "#d32f2f"
GREY       <- "#6b7280"

theme_elicit <- function() {
  theme_minimal(base_size = 14) +
    theme(
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_blank(),
      plot.title = element_text(face = "bold", size = 15, colour = NAVY),
      plot.subtitle = element_text(colour = GREY, size = 12),
      axis.title = element_text(colour = GREY, size = 11)
    )
}

N_DRAWS <- 10000

# SHELF's sampleFit() column names are NOT the names in the fitted object:
# Log.normal -> lognormal, Student.t -> t. Look them up rather than assume;
# a misspelt column returns NULL rather than an error.
FAMILY_LOOKUP <- c(
  "Normal"      = "normal",
  "Student.t"   = "t",
  "Gamma"       = "gamma",
  "Log.normal"  = "lognormal",
  "Log.Student.t" = "logt",
  "Beta"        = "beta",
  "Mirror gamma"   = "mirrorgamma",
  "Mirror log normal" = "mirrorlognormal",
  "Mirror log Student.t" = "mirrorlogt"
)

# Families that cannot produce a value outside the stated limits.
BOUNDED_FAMILIES <- c("Beta")

# SHELF's ssq table and its parameter tables have not always agreed on casing
# or punctuation between versions. Match loosely rather than assume, and return
# NA rather than erroring if a family genuinely isn't there.
norm_key <- function(x) gsub("[^a-z]", "", tolower(x))

ssq_for <- function(fit, family) {
  ss <- fit$ssq
  if (is.null(ss)) return(NA_real_)
  nms <- names(ss)
  if (is.null(nms)) return(NA_real_)
  hit <- which(norm_key(nms) %in% norm_key(c(family, FAMILY_LOOKUP[[family]])))
  if (!length(hit)) return(NA_real_)
  v <- suppressWarnings(as.numeric(unlist(ss[[hit[1]]])))
  if (!length(v) || all(is.na(v))) return(NA_real_)
  min(v, na.rm = TRUE)
}

# Which families did this fit actually produce a parameter table for?
families_in <- function(fit) {
  nms <- names(fit)
  names(FAMILY_LOOKUP)[norm_key(names(FAMILY_LOOKUP)) %in% norm_key(nms)]
}

draws_for <- function(fit, family, n = N_DRAWS) {
  s <- SHELF::sampleFit(fit, n = n)
  cols <- colnames(s)
  hit <- which(norm_key(cols) %in% norm_key(c(FAMILY_LOOKUP[[family]], family)))
  if (!length(hit)) {
    # Fall back to whatever the object actually offers, loudly.
    hit <- 1L
    warning(sprintf("Family '%s' not in sampleFit output (%s); using '%s'.",
                    family, paste(cols, collapse = ", "), cols[1]))
  }
  as.numeric(s[, hit[1]])
}

fmt <- function(x, prefix = "", dp = 0) {
  paste0(prefix, formatC(x, format = "f", big.mark = ",", digits = dp))
}

# ---------------------------------------------------------------------------
# UI
# ---------------------------------------------------------------------------

ui <- fluidPage(
  tags$head(tags$style(HTML(sprintf("
    body { background:#fcfcfb; color:#1c1c1c;
           font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Helvetica,Arial,sans-serif; }
    .container-fluid { max-width: 1180px; }
    h2 { font-weight:650; letter-spacing:-.02em; color:%s; margin-top:18px; }
    .step { font-size:11px; font-weight:700; letter-spacing:.08em;
            text-transform:uppercase; color:#9ca3af; margin:20px 0 4px; }
    .ask { background:#fff; border:1px solid #e5e7eb; border-radius:10px;
           padding:14px 16px; margin-bottom:14px; }
    .ask .q { font-size:15px; font-weight:600; color:%s; line-height:1.4; }
    .ask .why { font-size:12.5px; color:#6b7280; margin-top:4px; line-height:1.45; }
    .locked { opacity:.42; }
    .verdict { background:#f6f8fb; border-left:3px solid %s; padding:12px 16px;
               border-radius:0 6px 6px 0; font-size:14.5px; line-height:1.55;
               margin:14px 0; }
    .warn { background:#fdf3f3; border-left:3px solid %s; padding:12px 16px;
            border-radius:0 6px 6px 0; font-size:14px; line-height:1.55;
            margin:14px 0; }
    .big { font-size:34px; font-weight:300; letter-spacing:-.02em; color:%s; }
    table.shiny-table td, table.shiny-table th { font-size:13.5px; }
  ", NAVY, NAVY, NAVY, RED, NAVY)))),

  h2("Elicit"),
  p(style = "color:#6b7280;max-width:74ch;margin-bottom:4px;",
    "Ask three questions, see what they imply, and let the person correct them ",
    "before the number goes into a model. Chapter 23's quartile method, ",
    "with the feedback loop that is the whole point of it."),

  fluidRow(
    # ------------------------------------------------------------- left: ask
    column(
      4,
      div(class = "step", "Step 0 — what are we asking about?"),
      textInput("question", NULL, width = "100%",
                value = "The net cost of one departure, after replacement"),
      fluidRow(
        column(6, textInput("prefix", "Unit prefix", value = "£")),
        column(6, numericInput("dp", "Decimal places", value = 0,
                               min = 0, max = 4, step = 1))
      ),

      div(class = "step", "Step 1 — the limits, asked first"),
      div(class = "ask",
          div(class = "q", textOutput("q_limits", inline = TRUE)),
          div(class = "why",
              "Ask for the range they'd be astonished to fall outside. ",
              "Limits first: ask for a best guess first and everything after ",
              "it gets anchored to it.")),
      fluidRow(
        column(6, numericInput("lower", "Lowest plausible", value = NA)),
        column(6, numericInput("upper", "Highest plausible", value = NA))
      ),

      uiOutput("quartile_inputs"),

      div(class = "step", "Distribution family"),
      uiOutput("family_ui"),
      checkboxInput("bounded_only",
                    "Only offer families that respect the limits", TRUE),

      div(class = "step", "Who answered?"),
      textInput("expert", NULL, value = "Head of L&D", width = "100%"),
      actionButton("save", "Save this expert", class = "btn-primary"),
      actionButton("clear", "Clear all"),
      br(), br(),
      downloadButton("dl", "Download draws (.csv)")
    ),

    # ------------------------------------------------------- right: feedback
    column(
      8,
      tabsetPanel(
        id = "tabs",
        tabPanel(
          "What they said",
          br(),
          uiOutput("fit_status"),
          plotOutput("fitplot", height = "330px"),
          uiOutput("ssq_note"),
          div(class = "step", "Read these back to them"),
          p(style = "font-size:13.5px;color:#6b7280;max-width:74ch;",
            "The rows marked — are the ones they never gave you. Those are the ",
            "fit's interpolation, and they are the ones worth checking: ",
            "“this says a one-in-ten chance it comes in below X. Does that sound right?” ",
            "If they balk, change a number on the left and watch this move."),
          tableOutput("feedback")
        ),

        tabPanel(
          "Shade a region",
          br(),
          div(class = "step", "The question a stakeholder actually asks"),
          fluidRow(
            column(4, selectInput("shade_type", "Ask",
                                  c("Chance it is above..."  = "above",
                                    "Chance it is below..."  = "below",
                                    "Chance it is between..." = "between"))),
            column(4, numericInput("shade_a", "Value", value = NA)),
            column(4, conditionalPanel(
              "input.shade_type == 'between'",
              numericInput("shade_b", "and", value = NA)))
          ),
          uiOutput("shade_answer"),
          plotOutput("shadeplot", height = "340px")
        ),

        tabPanel(
          "Compare experts",
          br(),
          uiOutput("pool_status"),
          plotOutput("poolplot", height = "360px"),
          uiOutput("pool_warning"),
          tableOutput("pool_table")
        )
      )
    )
  ),

  br(),
  p(style = "color:#9ca3af;font-size:12.5px;border-top:1px solid #e5e7eb;padding-top:14px;",
    "Fitting by SHELF (Oakley). Companion to ",
    tags$em("Bayesian Statistics for People Analytics"), ", Chapter 23.")
)

# ---------------------------------------------------------------------------
# Server
# ---------------------------------------------------------------------------

server <- function(input, output, session) {

  experts <- reactiveVal(list())

  limits_ok <- reactive({
    !is.null(input$lower) && !is.null(input$upper) &&
      is.finite(input$lower) && is.finite(input$upper) &&
      input$upper > input$lower
  })

  output$q_limits <- renderText({
    q <- if (nzchar(input$question)) input$question else "the quantity"
    q <- paste0(tolower(substr(q, 1, 1)), substring(q, 2))
    sprintf("“Thinking about %s — what is the lowest it could plausibly be? And the highest?”", q)
  })

  # Quartile inputs stay locked until the limits are in. This is the point.
  output$quartile_inputs <- renderUI({
    if (!limits_ok()) {
      return(div(
        class = "step locked",
        "Step 2 — locked until the limits are given",
        div(class = "ask locked",
            div(class = "q", "“Given that range, what value is it equally likely to be above or below?”"),
            div(class = "why", "Enter the two limits above to unlock."))
      ))
    }
    mid <- (input$lower + input$upper) / 2
    tagList(
      div(class = "step", "Step 2 — the median, then the quartiles"),
      div(class = "ask",
          div(class = "q", "“Given that range, what value is it equally likely to be above or below?”"),
          div(class = "why",
              "Then: “thinking only about the lower half, what splits that in two?” ",
              "and the same for the upper half. Each question halves a range, ",
              "which people are much better at than ‘how likely is this?’")),
      fluidRow(
        column(4, numericInput("q1", "Lower quartile", value = NA)),
        column(4, numericInput("med", "Median", value = round(mid))),
        column(4, numericInput("q3", "Upper quartile", value = NA))
      )
    )
  })

  vals_ok <- reactive({
    limits_ok() &&
      !is.null(input$q1) && !is.null(input$med) && !is.null(input$q3) &&
      all(is.finite(c(input$q1, input$med, input$q3))) &&
      input$q1 < input$med && input$med < input$q3 &&
      input$lower < input$q1 && input$q3 < input$upper
  })

  fit <- reactive({
    req(vals_ok())
    SHELF::fitdist(
      vals  = c(input$q1, input$med, input$q3),
      probs = c(0.25, 0.50, 0.75),
      lower = input$lower,
      upper = input$upper
    )
  })

  available_families <- reactive({
    fams <- families_in(fit())
    if (!length(fams)) fams <- "Normal"
    if (isTRUE(input$bounded_only)) {
      keep <- intersect(fams, BOUNDED_FAMILIES)
      if (length(keep)) fams <- keep
    }
    fams
  })

  output$family_ui <- renderUI({
    if (!vals_ok()) return(p(style = "color:#9ca3af;font-size:13px;",
                             "Available once the five numbers are in."))
    fams <- available_families()
    ss <- vapply(fams, function(k) ssq_for(fit(), k), numeric(1))
    best <- if (all(is.na(ss))) fams[1] else fams[which.min(ss)]
    selectInput("family", NULL, choices = fams, selected = best)
  })

  output$fit_status <- renderUI({
    if (!limits_ok())
      return(div(class = "verdict",
                 "Start with the limits. ",
                 tags$b("Ask for the range they'd be astonished to fall outside"),
                 " — before anything else."))
    if (!vals_ok())
      return(div(class = "verdict",
                 "Now the median and the two quartiles. They must sit inside the ",
                 "limits and in increasing order: lower < Q1 < median < Q3 < upper."))
    NULL
  })

  output$fitplot <- renderPlot({
    req(vals_ok(), input$family)
    d <- draws_for(fit(), input$family)
    q <- quantile(d, c(0.25, 0.5, 0.75))
    ggplot(data.frame(x = d), aes(x = x)) +
      geom_density(fill = NAVY_LIGHT, colour = NAVY, alpha = 0.45, linewidth = 1) +
      geom_vline(xintercept = c(input$q1, input$med, input$q3),
                 colour = RED, linetype = "dashed", linewidth = 0.7) +
      scale_x_continuous(labels = function(z) fmt(z, input$prefix, input$dp)) +
      labs(
        title = "What those three answers imply",
        subtitle = sprintf(
          "Red dashed = the three values %s gave you. Fitted %s.",
          if (nzchar(input$expert)) input$expert else "they", input$family),
        x = input$question, y = NULL
      ) +
      theme_elicit()
  })

  output$ssq_note <- renderUI({
    req(vals_ok(), input$family)
    f <- fit()
    all_ss <- vapply(families_in(f), function(k) ssq_for(f, k), numeric(1))
    this_ss <- ssq_for(f, input$family)
    if (is.na(this_ss) || all(is.na(all_ss))) return(NULL)
    best_ss <- min(all_ss, na.rm = TRUE)
    if (this_ss <= best_ss * 1.0001) {
      div(class = "verdict",
          tags$b("This is also the closest fit to the three points."),
          " No trade-off to declare.")
    } else {
      div(class = "verdict",
          sprintf("This is not the closest fit — another family passes nearer to the three points (%.5f vs %.5f). ",
                  this_ss, best_ss),
          tags$b("That is usually the right trade."),
          " Sum of squared error measures how close a curve passes to three points and says ",
          "nothing about what it does beyond them. An unbounded family will happily produce ",
          "impossible values. Pick the family for the property you need, then say what it cost you — ",
          "and if the penalty is large, go back to the expert, because their judgement may not be that shape.")
    }
  })

  output$feedback <- renderTable({
    req(vals_ok(), input$family)
    ps <- c(0.05, 0.10, 0.25, 0.50, 0.75, 0.90, 0.95)
    d <- draws_for(fit(), input$family)
    qs <- as.numeric(quantile(d, ps))
    given <- ifelse(ps %in% c(0.25, 0.50, 0.75), "you asked", "—")
    data.frame(
      Percentile = paste0(ps * 100, "th"),
      Value = fmt(qs, input$prefix, input$dp),
      Source = given,
      `Read back as` = sprintf("a %d-in-100 chance it is below %s",
                               round(ps * 100), fmt(qs, input$prefix, input$dp)),
      check.names = FALSE
    )
  }, striped = TRUE, width = "100%")

  # --------------------------------------------------------------- shading
  shade_result <- reactive({
    req(vals_ok(), input$family, is.finite(input$shade_a))
    d <- draws_for(fit(), input$family)
    if (input$shade_type == "above") {
      list(p = mean(d > input$shade_a), lo = input$shade_a, hi = Inf, d = d)
    } else if (input$shade_type == "below") {
      list(p = mean(d < input$shade_a), lo = -Inf, hi = input$shade_a, d = d)
    } else {
      req(is.finite(input$shade_b))
      a <- min(input$shade_a, input$shade_b); b <- max(input$shade_a, input$shade_b)
      list(p = mean(d > a & d < b), lo = a, hi = b, d = d)
    }
  })

  output$shade_answer <- renderUI({
    r <- try(shade_result(), silent = TRUE)
    if (inherits(r, "try-error") || is.null(r))
      return(div(class = "verdict",
                 "Enter a value. This is the question stakeholders actually ask, ",
                 "and it is one line once you have draws."))
    div(class = "verdict",
        span(class = "big", sprintf("%.0f%%", 100 * r$p)),
        br(),
        sprintf("chance that %s is %s.",
                tolower(input$question),
                switch(input$shade_type,
                       above   = paste("above", fmt(r$lo, input$prefix, input$dp)),
                       below   = paste("below", fmt(r$hi, input$prefix, input$dp)),
                       between = paste("between", fmt(r$lo, input$prefix, input$dp),
                                       "and", fmt(r$hi, input$prefix, input$dp)))))
  })

  output$shadeplot <- renderPlot({
    r <- shade_result()
    dd <- density(r$d, n = 1024)
    df <- data.frame(x = dd$x, y = dd$y)
    df$sel <- df$x >= r$lo & df$x <= r$hi
    ggplot(df, aes(x, y)) +
      geom_area(fill = NAVY_LIGHT, alpha = 0.45) +
      geom_area(data = df[df$sel, ], fill = NAVY, alpha = 0.85) +
      geom_line(colour = NAVY, linewidth = 1) +
      scale_x_continuous(labels = function(z) fmt(z, input$prefix, input$dp)) +
      labs(title = sprintf("%.0f%% of the distribution is shaded", 100 * r$p),
           subtitle = "Same object, different question. Nothing was refitted.",
           x = input$question, y = NULL) +
      theme_elicit()
  })

  # --------------------------------------------------------------- experts
  observeEvent(input$save, {
    req(vals_ok(), input$family)
    e <- experts()
    nm <- if (nzchar(input$expert)) input$expert else paste("Expert", length(e) + 1)
    e[[nm]] <- list(draws = draws_for(fit(), input$family),
                    vals = c(input$q1, input$med, input$q3))
    experts(e)
    showNotification(sprintf("Saved %s (%d in total).", nm, length(e)),
                     type = "message")
  })

  observeEvent(input$clear, { experts(list()) })

  output$pool_status <- renderUI({
    e <- experts()
    if (length(e) == 0)
      return(div(class = "verdict",
                 "Elicit from one person, press ", tags$b("Save this expert"),
                 ", then change the numbers and save the next. ",
                 "Three is usually enough."))
    NULL
  })

  output$poolplot <- renderPlot({
    e <- experts()
    req(length(e) > 0)
    df <- do.call(rbind, lapply(names(e), function(nm)
      data.frame(who = nm, x = e[[nm]]$draws)))
    pooled <- data.frame(who = "Pooled", x = unlist(lapply(e, `[[`, "draws")))
    ggplot() +
      geom_density(data = df, aes(x = x, colour = who), linewidth = 1,
                   alpha = 0, show.legend = TRUE) +
      geom_density(data = pooled, aes(x = x), fill = NAVY, colour = NAVY,
                   alpha = 0.25, linewidth = 1.2) +
      scale_x_continuous(labels = function(z) fmt(z, input$prefix, input$dp)) +
      scale_colour_manual(values = rep(c(NAVY_MID, RED, GREY, "#8a6d3b"),
                                       length.out = length(e))) +
      labs(title = "Each expert, and the pool",
           subtitle = "Filled navy is the linear pool. Look at it before you use it.",
           x = input$question, y = NULL, colour = NULL) +
      theme_elicit()
  })

  output$pool_warning <- renderUI({
    e <- experts()
    if (length(e) < 2) return(NULL)
    pooled <- unlist(lapply(e, `[[`, "draws"))
    dd <- density(pooled, n = 512)
    # Count interior local maxima that are not trivial bumps.
    y <- dd$y
    peaks <- which(diff(sign(diff(y))) == -2) + 1
    peaks <- peaks[y[peaks] > 0.25 * max(y)]
    if (length(peaks) >= 2) {
      div(class = "warn",
          tags$b("This pool has two humps."),
          " Averaging confident disagreement produces a prior nobody holds: it says the ",
          "truth is likely near one value or the other and unlikely in between, which is a ",
          "claim neither expert made. Do not pool your way past this. ",
          tags$b("Go back to the room"),
          " and build one distribution together — or find out whether they are disagreeing ",
          "about a fact (pool it) or about what counts as a cost (run the decision twice).")
    } else {
      div(class = "verdict",
          "Single-peaked. Worth noting how far apart the individual curves are anyway: ",
          tags$b("wide disagreement is a finding, not noise."),
          " It says the organisation does not have a shared view of what to expect — ",
          "better discovered here than after the programme underperforms someone's private expectation.")
    }
  })

  output$pool_table <- renderTable({
    e <- experts()
    req(length(e) > 0)
    rows <- lapply(names(e), function(nm) {
      q <- quantile(e[[nm]]$draws, c(0.05, 0.25, 0.5, 0.75, 0.95))
      data.frame(Expert = nm,
                 `5th` = fmt(q[1], input$prefix, input$dp),
                 `25th` = fmt(q[2], input$prefix, input$dp),
                 Median = fmt(q[3], input$prefix, input$dp),
                 `75th` = fmt(q[4], input$prefix, input$dp),
                 `95th` = fmt(q[5], input$prefix, input$dp),
                 check.names = FALSE)
    })
    do.call(rbind, rows)
  }, striped = TRUE, width = "100%")

  output$dl <- downloadHandler(
    filename = function() "elicited-draws.csv",
    content = function(file) {
      e <- experts()
      if (length(e) == 0) {
        req(vals_ok(), input$family)
        out <- data.frame(expert = input$expert, draw = draws_for(fit(), input$family))
      } else {
        out <- do.call(rbind, lapply(names(e), function(nm)
          data.frame(expert = nm, draw = e[[nm]]$draws)))
      }
      utils::write.csv(out, file, row.names = FALSE)
    }
  )
}

shinyApp(ui, server)
