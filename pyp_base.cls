%%%%% Options %%%%%

\RequirePackage{xifthen} % conditional commands
\newboolean{@isScience}

\DeclareOption{science}{
    \setboolean{@isScience}{true}
}

\DeclareOption{math}{
    \setboolean{@isScience}{false}
}

%%%%%%%%%%

%%%%% load base document class %%%%%

\ProcessOptions\relax
\LoadClass[11pt]{article}

%%%%%%%%%%

%%%%% Packages setting %%%%%

% margin settings
\RequirePackage[a4paper,tmargin=1.5cm,bmargin=2cm,lmargin=2cm,rmargin=2cm]{geometry} % margin
    \linespread{1.5}
\RequirePackage{changepage}

% math
\RequirePackage{amsmath,amssymb,amsfonts,amsthm} % ams math libraries
\RequirePackage{delarray} % refinement of math array
\RequirePackage{empheq} % emphasizing equations
    \newenvironment{tagcases}[1][]
    {\empheq[left={#1\empheqlbrace}]{alignat=2}}
    {\endempheq}

% science
\RequirePackage{siunitx} % SI units
    \sisetup{per-mode=symbol}
    \DeclareSIUnit\permille{\text{\textperthousand}}
\RequirePackage[version=4]{mhchem} % chemical expressions
\RequirePackage{chemfig} % chemical figures
% \RequirePackage{physics} % physical notations

% enumerate
\RequirePackage{zhnumber} % chinese numbering
\RequirePackage[inline,shortlabels]{enumitem} % enumerate customizing
\RequirePackage{tasks} % offer horizontal enumerate
    \ifthenelse{\boolean{@isScience}}{
        \settasks{label={(\Alph*)},label-offset=3pt,label-width=16pt,item-indent=2em,after-item-skip=0.3em}
    }{
        \settasks{label={(\arabic*)},label-offset=1pt,label-width=16pt,item-indent=2em,after-item-skip=0.3em}
    }

% counter
\RequirePackage{totcount} % tracking value of counter

% figures & graphics
\RequirePackage{graphicx} % graphics
    \graphicspath{{../}{../../}{../../../}{../../../../}}
\RequirePackage{pgfplots} % drawing pgf graphs
    \pgfplotsset{compat=1.18}
\RequirePackage{tikz} % tikz graphics
    \usetikzlibrary{arrows,shapes.geometric}
\RequirePackage{float} % controling floating objects
\RequirePackage{subfig,wrapfig} % subfigures and wrapped figures
\RequirePackage{framed} % framed regions that can break across pages

% languages & text
\RequirePackage{xeCJK} % chinese fonts
    \xeCJKsetup{
        PunctStyle=plain,
        CJKmath=true,
        AutoFakeSlant=0.2
    }
\RequirePackage{xeCJKfntef}
\RequirePackage{microtype} % adjusting hypenation
\RequirePackage{hanging} % hanging paragraphs

% alignment
\RequirePackage[export]{adjustbox} % adjust boxes
    \newadjustboxenv{alignbox}{
        valign=t,
        center
    }

    \newcommand{\abox}[2]{
        \begin{minipage}[t]{#1\linewidth}
            \alignbox{
                {#2}
            }
        \end{minipage}
        \vspace{0.6\belowdisplayskip}
    }

    \newadjustboxenv{fwbox}{
        noindent,
        leavevmode,
        valign=t,
        center,
        margin=0em {1.1em plus 0.4em minus 0.2em},
    }
\RequirePackage{array} % array
\RequirePackage{makecell} % handling single cell in tables
\RequirePackage{multicol} % multiple columns
\RequirePackage{multirow} % multiple rows
\RequirePackage{tabto} % defining tabs
\RequirePackage{booktabs} % publish-quality tables
    \renewcommand{\arraystretch}{1.1}

% citations
\RequirePackage{cite} % numeric citations
\RequirePackage{fancyref} % references
\RequirePackage{nameref} % making reference of section names, etc.
\RequirePackage{url}

% fonts
\RequirePackage[T1]{fontenc} % font encoding
\RequirePackage{moresize} % defining more font sizes
\RequirePackage{fontspec} % font declaration
    \IfFontExistsTF{fonts/SourceHanSerifTW-Regular.otf}{ % finding the fonts folder
        \newcommand{\font@dir}{ = fonts/}
    }{
        \IfFontExistsTF{../fonts/SourceHanSerifTW-Regular.otf}{
            \newcommand{\font@dir}{ = ../fonts/}
        }{
            \IfFontExistsTF{../../fonts/SourceHanSerifTW-Regular.otf}{
                \newcommand{\font@dir}{ = ../../fonts/}
            }{
                \IfFontExistsTF{../../../fonts/SourceHanSerifTW-Regular.otf}{
                    \newcommand{\font@dir}{ = ../../../fonts/}
                }{
                    \newcommand{\font@dir}{}
                }
            }
        }
    }

    \newfontfamily\nfont{PoiretOne}[
        Path \font@dir,
        Extension = .ttf,
        UprightFont = *-Regular,
    ]
    \setCJKmainfont{SourceHanSerifTW}[
        Path \font@dir,
        Extension = .otf,
        UprightFont = *-Regular,
        BoldFont = *-Bold
    ]
    \setCJKsansfont{TaipeiSansTCBeta}[
        Path \font@dir,
        Extension = .ttf,
        UprightFont = *-Regular,
        BoldFont = *-Bold
    ]
    \setCJKmonofont{NotoSansTC}[
        Path \font@dir,
        Extension = .otf,
        UprightFont = *-Regular,
        BoldFont = *-Bold
    ]

% arithmetic
\RequirePackage{lastpage}
\RequirePackage{calc}
\RequirePackage[nomessages]{fp}

%miscellaneous
\RequirePackage{footmisc} % customizing footnotes
\RequirePackage{etoolbox} % a useful tool box (X  defining some new primitive commands
\RequirePackage{xparse} % document command parser

%%%%%%%%%%

%%%%% Section Customizing %%%%%

\renewcommand\thesection{\zhnum{section}}
\RequirePackage{titlesec}
\titleformat{\section}[hang]
    {\large\bfseries}
    {\thesection、}
    {0pt}
    {}
    []
    
\makeatletter
\g@addto@macro\bfseries{\boldmath}
\makeatother

%%%%%%%%%%

%%%%% Self-defined Commands %%%%%

% \QED
\newcommand*{\QED}{\null\nobreak\hfill\ensuremath{\square}}

% \arc
\makeatletter
    \DeclareFontFamily{U}{tipa}{}
    \DeclareFontShape{U}{tipa}{m}{n}{<->tipa10}{}
    \newcommand{\arc@char}{{\usefont{U}{tipa}{m}{n}\symbol{62}}}%
    \newcommand{\arc}[1]{\mathpalette\arc@arc{#1}}
    \newcommand{\arc@arc}[2]{%
        \sbox0{$\m@th#1#2$}%
        \vbox{
            \hbox{\resizebox{\wd0}{\height}{\arc@char}}
            \nointerlineskip
        \box0
      }%
    }
\makeatother

% \parallel
\renewcommand{\parallel}{\mathbin{\!/\mkern-5mu/\!}}

% roman numbers
\makeatletter
    \newcommand*{\rom}[1]{\expandafter\@slowromancap\romannumeral #1@}
\makeatother

%%%%%%%%%%
