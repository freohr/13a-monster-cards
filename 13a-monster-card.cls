\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{13a-monster-card-par}[2024-07-12 Cards for monsters in the 13th Age RPG]

\LoadClass[a4paper]{article}
\RequirePackage[portrait,left=0.7cm,right=1cm,top=0.8cm,bottom=0.8cm]{geometry}

\RequirePackage{calc}
\RequirePackage{hanging}
\RequirePackage{enumitem}
\RequirePackage{xargs}
\RequirePackage{etoolbox}
\RequirePackage{ifthen}
\RequirePackage[super]{nth}
\RequirePackage{stringstrings}
\RequirePackage{intcalc}

\RequirePackage{fontspec}
\setmainfont{Fira Sans}

\setlength{\parindent}{0 pt}

\pagestyle{empty}

\setlist[itemize]{label=,noitemsep,itemindent=-0.5cm,left=0pt}

\hbadness=10000

\newcommand{\titlefont}[1][1]{\large}
\newcommand{\sourcefont}[1][1]{\footnotesize}
\newcommand{\typefont}[1][1]{\normalsize}
\newcommand{\defensefont}[1][1]{\large}
\newcommand{\bodyfont}[1][1]{\small}
\newcommand{\headerfont}[1][1]{\normalsize}

\newcounter{cardCount}

\newcommand{\monsterCard}[1]
{
  \stepcounter{cardCount}
  \ifnumgreater{\intcalcMod{\value{cardCount}}{4}}{1}{
    \vspace{0.8cm}
  }{}
  \parbox[t][13.5cm]{9.5cm}{
    #1
  }%
  \quad
}

\newcommand{\monsterName}[1]{
  \begin{center}
    \titlefont\textsc{\textbf{#1}}
  \end{center}
}

% parameter order: level role type size? strength? mook?
\newcommandx{\monsterType}[6][4,5,6]{ 
  \textit{\notblank{#4}{\capitalize{#4} }{}\notblank{#5}{\capitalize{#5} }{}\nth{#1} level\notblank{#6}{ mook}{} \capitalize{#2}} [\textsc{#3}]
}

\newcommand{\initiative}[1]{
  Initiative +#1\\
}

\newcommand{\vulnerabilities}[1]{
  Vulnerabilities: \capitalize{#1} \\ 
}

\newcommand{\trait}[2]
{
  \item\textit{#1:} #2
}

\newcommandx{\action}[3][3]{
  \item\textbf{#1} --- #2
    \notblank{#3}
    {
    \begin{hangparas}{0.5cm}{1}
      \begin{itemize}
          #3
      \end{itemize}
    \end{hangparas}
    }{}
}

\newcommand{\actions}[1]{
  \smallskip
  \begin{hangparas}{0.5cm}{1}
    \begin{itemize}
      #1
    \end{itemize}
  \end{hangparas}
}

\let\traits\actions

\newcommand{\triggeredActions}[1]{
  \smallskip
  {\underline{\textsc{Triggered Actions}}}
  \begin{itemize}
      #1
  \end{itemize}
}

\newcommand{\nastierTraits}[1]{
  \smallskip
  {\underline{\textsc{Nastier Traits}}}
  \begin{itemize}
      #1
  \end{itemize}
}

\newcommand{\monsterDefenses}[4]{
  \vfill
	\begin{center}
		\defensefont{}
		\begin{tabular}{*{2}{p{3cm}}}
			\textbf{AC} #1 \\
			\textbf{PD} #2 & \textbf{HP #4} \\
			\textbf{MD} #3
		\end{tabular}
  \end{center}
}

