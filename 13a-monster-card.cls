\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{13a-monster-card}[2024-07-25 Cards for monsters in the 13th Age RPG]

\LoadClass[a4paper]{article}
\RequirePackage[portrait,left=0.6cm,right=0.9cm,top=0.7cm,bottom=0cm]{geometry}

\RequirePackage{calc}
\RequirePackage{hanging}
\RequirePackage{enumitem}
\RequirePackage{xargs}
\RequirePackage{etoolbox}
\RequirePackage{ifthen}
\RequirePackage[super]{nth}
\RequirePackage{stringstrings}
\RequirePackage{intcalc}
\RequirePackage[skip=20pt , indent=0pt]{parskip}
\RequirePackage{multido}
\newcommand{\Repeat}{\multido{}}

\RequirePackage{fontspec}
\setmainfont{Fira Sans}

\setlength{\parindent}{0 pt}
% \setlength{\parskip}{2pt}

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
\newtoggle{mook}

\newcommand{\monsterCard}[1]
{
  \stepcounter{cardCount}
  \ifnumgreater{\intcalcMod{\value{cardCount}}{4}}{1}{
    \vspace{0.75cm}
  }{}
  \parbox[t][13.5cm]{9.5cm}{
    #1
  }%
  \togglefalse{mook}
  \quad%
}

\newcommand{\monsterName}[1]{
  \begin{center}
    \titlefont\textsc{\textbf{#1}}
  \end{center}
  \def\internalName{#1}
}

% parameter order: level role type size? strength? mook?
\newcommandx{\monsterType}[6][4,5,6]{ 
  \vspace{5pt}
  \notblank{#6}{\toggletrue{mook}}{\togglefalse{mook}}
  \textit{\nth{#1} level \notblank{#5}{#5 }{}\notblank{#6}{mook }{}\notblank{#2}{\capitalize{#2}}{\capitalize{troop}}} [\textsc{\notblank{#4}{\capitalize{#4} }{}#3}]\\
}

\newcommand{\initiative}[1]{
  Initiative +#1
}

\newcommand{\vulnerabilities}[1]{
  \\
  Vulnerabilities: \capitalize{#1}
}

\newcommandx{\trait}[3][3]
{
  \item\textit{#1:} #2
  \notblank{#3}
  {
    \begin{hangparas}{0.5cm}{1}
      \begin{itemize}
          #3
      \end{itemize}
    \end{hangparas}
  }{}
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
  \customGroup{#1}
}

\let\traits\actions

\newcommand{\triggeredActions}[1]{
  \customGroup[Triggered Attacks]{#1}
}

\newcommand{\nastierTraits}[1]{
  \customGroup[Nastier Specials]{#1}
}

\newcommand{\customGroup}[2][]{
  \vfill
  \notblank{#1}{{\underline{\textsc{#1}}}}{}
  \vspace{2pt}
  \begin{hangparas}{0.5cm}{1}
    \begin{itemize}
      #2
    \end{itemize}
  \end{hangparas}%
}

\newcommandx{\monsterDefenses}[8][2,4,6,8]{
  \Repeat{10}{\vfill}
	\begin{center}
		\defensefont{}
		\begin{tabular}{*{2}{p{3cm}}}
			\textbf{AC}\notblank{#2}{\textsubscript{#2}}{} #1 \\
			\textbf{PD}\notblank{#4}{\textsubscript{#4}}{} #3 & \textbf{HP\notblank{#8}{\textsubscript{#8}}{} #7 \iftoggle{mook}{(mook)}{}} \\
			\textbf{MD}\notblank{#6}{\textsubscript{#6}}{} #5
		\end{tabular}
  \end{center}
  \iftoggle{mook}
  {
    \traits{
      \trait{Mook}{Kill one \internalName{} for every #4 damage dealt to the mob.}
    }
  }{}
}

