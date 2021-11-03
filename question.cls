\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{question}

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

\ProcessOptions\relax
\LoadClass[10pt,a4paper]{article}

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
\RequirePackage{physics} % physical notations
\RequirePackage{chemfig} % chemical figures

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
\RequirePackage{pgfplots} % drawing pgf graphs
    \pgfplotsset{compat=1.17}
\RequirePackage{tikz} % tikz graphics
    \usetikzlibrary{arrows,shapes.geometric}
\RequirePackage{float} % controling floating objects
\RequirePackage{subfig,wrapfig} % subfigures and wrapped figures 
\RequirePackage{framed} % framed regions that can break across pages

% languages & text
\RequirePackage{xeCJK} % chinese fonts
\usepackage{xeCJKfntef}
\RequirePackage{microtype} % adjusting hypenation
\RequirePackage{hanging} % hanging paragraphs

% alignment
\RequirePackage[export]{adjustbox} % adjust boxes
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

% fonts
\RequirePackage[T1]{fontenc} % font encoding
\RequirePackage{moresize} % defining more font sizes
\RequirePackage{fontspec} % font declaration
    \IfFontExistsTF{Fonts/NotoSerifTC-Regular.otf}{
        \newcommand{\font@dir}{Fonts/}
    }{
        \IfFontExistsTF{../Fonts/NotoSerifTC-Regular.otf}{
            \newcommand{\font@dir}{../Fonts/}
        }{
            \IfFontExistsTF{../../Fonts/NotoSerifTC-Regular.otf}{
                \newcommand{\font@dir}{../../Fonts/}
            }{
                \IfFontExistsTF{../../../Fonts/NotoSerifTC-Regular.otf}{
                    \newcommand{\font@dir}{../../../Fonts/}
                }{
                    \newcommand{\font@dir}{../../../../Fonts/}
                }
            }
        }
    }
    \newfontfamily\nfont{PoiretOne-Regular}[
        Extension = .ttf,
        Path = \font@dir,
    ]
    \setCJKmainfont{NotoSerifTC}[
        Extension = .otf,
        Path = \font@dir,
        UprightFont = *-Regular,
        BoldFont = *-Bold
    ]
    \setCJKsansfont{NotoSansTC}[
        Extension = .otf,
        Path = \font@dir,
        UprightFont = *-Regular,
        BoldFont = *-Bold
    ]
    \setCJKmonofont{NotoSansTC}[
        Extension = .otf,
        Path = \font@dir,
        UprightFont = *-Regular,
        BoldFont = *-Bold
    ]

% arithmetic
\RequirePackage{lastpage}
\RequirePackage{calc}
\RequirePackage[nomessages]{fp}

% miscellaneous
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
%%%%%%%%%%

%%%%% New Features %%%%%
\newcommand{\helloworld}[5]{%
    \hrule
    \vspace{10pt}
    \begin{minipage}[t]{0.2\linewidth}
        \vspace*{\fill}
        \begin{center}
            \Huge \nfont #1 \\[6pt]
            \large 學年度
        \end{center}
        \vspace*{\fill}
    \end{minipage}
    \hfill
    \begin{minipage}[t]{0.65\linewidth}
        \Large
        \vspace*{\fill}
        #2~#3甄選入學\\[9pt]
        #4能力檢定~試題本
        \vspace*{\fill}
    \end{minipage}
    \hrule 
    \vspace{10pt}
    \hspace{20pt}
    測驗時間：#5分鐘
    \hfill
    \textbf{\large 翻印必究}
    \hfill
    試卷：共\pageref{LastPage} 頁\hspace{40pt}
    \vspace{20pt}
}

\newcounter{partnum}

\newcounter{choice}
\ifthenelse{\boolean{@isScience}}{
        \renewcommand\thechoice{(\Alph{choice})}
    }{
        \renewcommand\thechoice{(\arabic{choice})}
    }
\newcommand\choicelabel{\thechoice}

\newenvironment{choices}{
    \list{\choicelabel}{%
        \usecounter{choice}\def\makelabel##1{\hss\llap{##1}}%
        \settowidth{\leftmargin}{W.\hskip\labelsep\hskip 0.2em}%
        \def\choice{%
            \item
        } % choice
        \def\task{
            \item
        }
        \labelwidth\leftmargin\advance\labelwidth-\labelsep
        \topsep=5pt
        \partopsep=0pt
        \itemsep=0em
    }%
}{\endlist}

\newenvironment{oneparchoices}{%
    \setcounter{choice}{0}%
    \def\choice{%
        \refstepcounter{choice}%
        \ifnum\value{choice}>1\relax
            \penalty -50\hskip 1em plus 1em\relax
        \fi
        \choicelabel
        \nobreak\enskip
    }
    % choice
    % If we're continuing the paragraph containing the question,
    % then leave a bit of space before the first choice:
    \ifvmode\else\enskip\fi
    \ignorespaces
}{}

\newcounter{number}
\setcounter{number}{0}
\newcounter{quesnum}
\setcounter{quesnum}{0}

\newenvironment{questions}{%
    \setcounter{quesnum}{0}
    \begin{enumerate}[%
        label=\arabic*.\ ,
        leftmargin=35pt,
        itemsep=1em
    ]
}{
    \setcounter{number}{\value{enumi}}%
    \end{enumerate}
}

\newenvironment{cquestions}{%
    \begin{enumerate}[label=\arabic*.\ , leftmargin=35pt]%
    \setcounter{enumi}{\value{number}}
}{%
    \end{enumerate}
    \setcounter{enumi}{0}
}

\newcommand{\question}[1][]{%
    \ifthenelse{%
        \isempty{#1}
    }{%
        \stepcounter{quesnum}
        \item[\thequesnum.]
    }{%
        \stepcounter{quesnum}
        \item[{\Large \textcircled{\small\sffamily #1}}~\thequesnum.]
    }
}

\newenvironment{parts}{%
    \begin{enumerate}[label=(\arabic*),leftmargin=35pt]
    \setcounter{partnum}{0}
}{%
    \end{enumerate}
}

\renewcommand{\part}[1][]{%
    \ifthenelse{%
        \isempty{#1}
    }{%
        \stepcounter{partnum}
        \item[(\thepartnum)]
    }{%
        \stepcounter{partnum}
        \item[{\Large \textcircled{\small\sffamily #1}}~(\thepartnum)]
    }
}

\newcommand{\crow}[1]{%
    \ifthenelse{%
        \isin{\includegraphics}{#1}
    }{%
        #1%
    }{%
        \includegraphics[width=0.9\linewidth]{#1}
    }
}

\newcommand{\minigraphics}[3][2]{%
    \begin{minipage}[#1]{#2\linewidth}%
        \adjustbox{valign=t}{\crow{#3}}
    \end{minipage}
}

\newenvironment{coneparchoices}{%
    \vspace{5pt}
    \hspace{1.5pt}
    \begin{enumerate*}[itemjoin = \hspace{10pt},label=(\Alph*)]%
}{%
    \end{enumerate*}
} 

\newenvironment{cchoices}{%
    \vspace{-5pt}
    \begin{enumerate}[label=(\Alph*)]%
}{%
    \end{enumerate}
}

\newcommand{\cminiset}[4]{%
    \begin{minipage}[t]{#1\linewidth}
        #2
        
        \begin{oneparchoices}
            #3
        \end{oneparchoices}
    \end{minipage}
    \FPeval{\result}{0.98-#1}
    \hfill
    \begin{minipage}[t]{\result\linewidth}
        \adjustbox{valign=t}{\crow{#4}}
    \end{minipage}
}

\newcommand{\miniset}[3]{%
    \begin{minipage}[t]{#1\linewidth}
        #2
    \end{minipage}
    \FPeval{\result}{0.98-#1}
    \hfill
    \begin{minipage}[t]{\result\linewidth}
        \adjustbox{valign=t}{\crow{#3}}
    \end{minipage}
}

\newcommand{\tminiset}[3]{%
    \begin{minipage}[t]{#1\linewidth}
        #2
    \end{minipage}
    \FPeval{\result}{0.98-#1}
    \hfill
    \begin{minipage}[t]{\result\linewidth}
        \adjustbox{valign=t}{\resizebox{\linewidth}{!}{#3}}
    \end{minipage}
}

\newcommand{\cxminiset}[4]{%
    \begin{minipage}[t]{#1\linewidth}
        #2
        \begin{choices}
            #3
        \end{choices}
    \end{minipage}
    \FPeval{\result}{0.98-#1}
    \hfill
    \begin{minipage}[t]{\result\linewidth}
        #4
    \end{minipage}
}

\newcommand{\cxfminiset}[4]{%
    \begin{minipage}[t]{#1\linewidth}
        #2
        
        \begin{choices}
            #3
        \end{choices}
    \end{minipage}
    \FPeval{\result}{0.98-#1}
    \hfill
    \begin{minipage}[t]{\result\linewidth}
        \adjustbox{valign=t}{\crow{#4}}
    \end{minipage}
}

\newcommand{\fig}[1]{%
    \adjustbox{valign=t,center}{#1}
}

\newcommand{\Fig}[1]{%
    \adjustbox{valign=t,center}{#1}
}

\newcommand{\comeout}{\hspace{-20pt}}

\newcommand{\fillin}{\ \rule{1.5cm}{0.5pt}\ }

\newcommand{\url}[1]{#1}

\newcommand{\wrong}[1]{\textbf{\CJKunderdblline{#1}}}